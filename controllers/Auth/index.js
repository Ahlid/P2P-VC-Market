'use strict';

// Load modules
const Joi = require('joi');
const Boom = require('boom');

// Declare internals
const internals = {};


/**
 * Issues a new JSON Web Token (JWT).
 *
 * @param server Server instance
 * @param userId User ID
 * @returns JSON Web Token
 */
internals.issueToken = async (server, userId) => {

    const token = await server.plugins.database.Token
        .query()
        .insert({
            subject_type: 'user',
            subject_id: userId
        });

    const options = {
        algorithm: 'RS256',
        issuer: 'urn:remotist.com',
        subject: token.subject_id,
        jwtid: token.id
    };

    // Issue a JSON Web Token
    return server.plugins.jwt.sign({}, server.settings.app.tls.key, options);
};

/**
 * Registers a new user and issues a new JSON Web Token.
 *
 * @param request
 * @param h
 */
internals.register = async (request, h) => {

    try {

        // Create the user
        const user = await request.server.plugins.database.User
            .query()
            .insert({

                email: request.payload.email,
                password: request.payload.password,
            });
        // Issue a new JSON Web Token
        const token = await internals.issueToken(request.server, user.id);

        // h
        return {token};
    } catch (err) {
        request.server.log('error', err);

        if (err.name === 'NonUniqueError') {
            return Boom.badRequest('USER_ALREADY_EXISTS');
        }

        return Boom.boomify(err);
    }
};

/**
 * Validates a user's username and password and issues a new JSON Web Token.
 *
 * @param request
 * @param h
 */
internals.login = async (request, h) => {

    try {
        // Fetch the user
        const user = await request.server.plugins.database.User
            .query().first().where({email: request.payload.email});

        if (!user) {
            return Boom.unauthorized('INVALID_EMAIL');
        }


        // Verify the password
        const matched = await user.verifyPassword(request.payload.password);
        if (!matched) {
            Boom.unauthorized('INVALID_PASSWORD');
        }

        // Issue a new JSON Web Token
        const token = await internals.issueToken(request.server, user.id);

        // Reply
        return {token};
    } catch (err) {
        request.server.log('error', err);
        return Boom.boomify(err);
    }
};

/**
 * Revokes the JSON Web Token used in the request.
 *
 * @param request
 * @param h
 */
internals.logout = async (request, h) => {

    try {
        // Revoke the token
        await request.server.plugins.database.Token
            .query()
            .findById(request.auth.credentials.id)
            .patch({
                revoked: true
            })

        // Reply with an empty response
        return {};
    } catch (err) {
        request.server.log('error', err);
        return Boom.boomify(err);
    }
};

/**
 * Changes a user's password, revokes any active tokens, and issues a new JSON Web Token.
 *
 * @param request
 * @param h
 */
internals.changePassword = async (request, h) => {

    try {
        // Fetch the user and any active tokens
        const user = await new request.server.plugins.database.User
            .findById(request.auth.credentials.userId);


        if (user === null) {
            return Boom.badRequest('INVALID_USER');
        }

        // Verify the old password
        const matched = await user.verifyPassword(request.payload.password);
        if (!matched) {
            return Boom.unauthorized('INVALID_PASSWORD');
        }

        // Revoke all active tokens
        // const revokeTokensTail = request.tail('Revoke Tokens');
        await user.$relatedQuery('tokens').where('revoked', false).patch({
            revoked: true
        });


        // Update the user's password
        await user.$query().patch({password: payload.newPassword});

        // Issue a new JSON Web Token
        const token = await internals.issueToken(request.server, user.id);

        // Reply
        return {token};
    } catch (err) {
        request.server.log('error', err);
        return Boom.boomify(err);
    }
};

const routes = [
    {
        method: 'POST',
        path: '/user/register',
        handler: internals.register,
        config: {
            validate: {
                payload: Joi.object({
                    email: Joi.string().email({errorLevel: true}).max(100)
                        .required()
                        .meta({unique: true})
                        .description('Email address.')
                        .example('john.doe@email.com'),
                    password: Joi.string().max(30)
                        .required()
                        .description('Password.')
                        .example('P4$$W0rD'),
                }),
                options: {abortEarly: false}
            },
            response: {
                schema: Joi.object({
                    token: Joi.string()
                        .description('JSON Web Token')
                        .example('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJKb2huIERvZSJ9.WUDuZWJ-75NwZfyahaHd0g6YYKoY7zVPbBQBdbsDUl8')
                })
            },
            description: 'Registers a new user.',
            tags: ['User API'],
            plugins: {
                //msgpack: true
            }
        }
    },
    {
        method: 'POST',
        path: '/user/login',
        handler: internals.login,
        config: {
            validate: {
                payload: {
                    email: Joi.string().email({errorLevel: true}).max(100)
                        .required()
                        .meta({unique: true})
                        .description('Email address.')
                        .example('john.doe@email.com'),
                    password: Joi.string().max(30)
                        .required()
                        .description('Password.')
                        .example('P4$$W0rD')
                }
            },
            response: {
                schema: Joi.object({
                    token: Joi.string()
                        .description('JSON Web Token')
                        .example('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJKb2huIERvZSJ9.WUDuZWJ-75NwZfyahaHd0g6YYKoY7zVPbBQBdbsDUl8')
                })
            },
            description: 'Validates a user\'s username and password and issues a new JSON Web Token.',
            tags: ['User API'],
            plugins: {
                //msgpack: true
            }
        }
    },
    {
        method: 'POST',
        path: '/user/logout',
        handler: internals.logout,
        config: {
            auth: 'user',
            validate: {
                payload: false
            },
            description: 'Revokes the token used in the request.',
            tags: ['User API'],
            plugins: {
                //msgpack: true
            }
        }
    },
    {
        method: 'POST',
        path: '/user/password',
        handler: internals.changePassword,
        config: {
            auth: 'user',
            validate: {
                payload: Joi.object({
                    oldPassword: Joi.string().max(30)
                        .required()
                        .description('Current password.')
                        .example('P4$$W0rD'),
                    newPassword: Joi.string().max(30)
                        .required()
                        .description('New password.')
                        .example('N3wP4$$W0rD')
                })
            },
            response: {
                schema: Joi.object({
                    token: Joi.string()
                        .description('JSON Web Token')
                        .example('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJKb2huIERvZSJ9.WUDuZWJ-75NwZfyahaHd0g6YYKoY7zVPbBQBdbsDUl8')
                })
            },
            description: 'Changes a user\'s password and issues a new JSON Web Token.',
            notes: 'Revokes any active tokens.',
            tags: ['User API'],
            plugins: {
                //msgpack: true
            }
        }
    },
];

module.exports = routes;
