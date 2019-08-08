'use strict';

// Load modules
const Joi = require('joi');
const Boom = require('boom');

// Declare internals
const internals = {};

internals.rowsByPage = 25;

/**
 * Registers a new user and issues a new JSON Web Token.
 *
 * @param request
 * @param h
 */
internals.listUsers = async (request, h) => {

    try {

        // Create the user
        const users = await request.server.plugins.database.User
            .query()
            .select('id', 'email', 'credits')
            .page((request.query.page - 1) ,  internals.rowsByPage);
        // Issue a new JSON Web Token

        // h
        return users;
    } catch (err) {
        request.server.log('error', err);
        return Boom.boomify(err);
    }
};


const routes = [
    {
        method: 'GET',
        path: '/user/',
        handler: internals.listUsers,
        config: {
            auth: 'user',
            validate: {
                query: Joi.object({
                    page: Joi.number().min(1).required()
                }),
                options: {abortEarly: false}
            },
            description: 'Lists users.',
            tags: ['User API'],

        }
    }
];

module.exports = routes;
