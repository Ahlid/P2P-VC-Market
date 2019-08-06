'use strict';

// Load modules
const Boom = require('boom');
const Hoek = require('hoek');
const Joi = require('joi');
const Cookie = require('cookie');
const JWT = require('jsonwebtoken');

// Declare internals
const internals = {};

// Schemas
internals.schemas = {
    schemeOptions: Joi.object({
        urlKey: Joi.string(),
        cookieKey: Joi.string(),
        jwt: Joi.object({
            secretOrPublicKey: Joi.alternatives().try(Joi.string(), Joi.binary()).required(),
            options: Joi.object({
                algorithms: Joi.array().items(Joi.string()),
                audience: Joi.array().items(Joi.string()).single(),
                issuer: Joi.array().items(Joi.string()).single(),
                subject: Joi.string(),
                jwtid: Joi.string(),
                ignoreExpiration: Joi.boolean(),
                ignoreNotBefore: Joi.boolean(),
                clockTolerance: Joi.number().integer().min(0)
            }),
            validateFunc: Joi.func().arity(2)
        }).required()
    })
};

// Defaults
internals.defaults = {
    schemeOptions: {
        urlKey: 'token',
        cookieKey: 'token'
    }
};

internals.scheme = (server, options) => {
    // Assert options are valid
    options = options || {};
    Joi.assert(options, internals.schemas.schemeOptions);

    // Apply options to the defaults
    const settings = Hoek.applyToDefaults(internals.defaults.schemeOptions, options);

    return {
        authenticate: async (request, h) => {

            // JSON Web Token (JWT) string.
            let token;

            // Preferred method:
            // Try to get the JWT string from the HTTP Authorization header
            if (request.headers.authorization) {
                const match = (/^Bearer\s+([^\s]+)$/ig).exec(request.headers.authorization);
                if (match !== null) {
                    token = match[1];
                }
            }

            // Fallback:
            // Try to get the JWT string from the query string.
            if (!token) {
                token = request.query[settings.urlKey];
            }

            // Fallback:
            // Try to get the JWT string from the cookies.
            if (!token && typeof request.headers.cookie === 'string') {
                token = Cookie.parse(request.headers.cookie)[settings.cookieKey];
            }

            // If no JWT string is present reply with a 401 Unauthorized error with a null error message. This
            // instructs hapi to try any additional authentication strategies configured in the route in order of
            // preference.
            if (!token) {
                return h.unauthenticated(Boom.unauthorized(null, 'Bearer'));
            }

            // Verify the JWT string
            const payload = await new Promise((resolve, reject) => {

                JWT.verify(token, settings.jwt.secretOrPublicKey, settings.jwt.options, (err, jwtPayload) => {

                    // If the verification fails reply with a 401 Unauthorized error with a the error message. No additional
                    // authentication strategies will be attempted.
                    if (err) {
                        reject(Boom.unauthorized(err.message, 'Bearer'));
                        return;
                    }

                    resolve(jwtPayload);
                });
            });

            // If a validate function has been supplied, use it to validate the payload and generate credentials.
            if (settings.jwt.validateFunc) {
                const { isValid, credentials } = await settings.jwt.validateFunc(request, payload);

                // If the validation fails reply with a 401 Unauthorized error with a null error message. This
                // instructs hapi to try any additional authentication strategies configured in the route in
                // order of preference.
                if (!isValid) {
                    return h.unauthenticated(Boom.unauthorized(null, 'Bearer'));
                }

                // Continue if successful.
                return h.authenticated({
                    credentials,
                    artifacts: payload
                });
            }

            return h.authenticated({
                credentials: {},
                artifacts: payload
            });
        }
    };
};

/**
 * Plugin name.
 *
 * @type {string}
 */
exports.name = 'jwt';

/**
 * Plugin package.
 */
exports.pkg = require('../package.json');

/**
 * Registers the plugin.
 *
 * @param server Server object.
 */
exports.register = (server) => {
    // Register the JWT authentication scheme
    server.auth.scheme('jwt', internals.scheme);

    // Expose the JWT sign function;
    server.expose('sign', JWT.sign);

    server.log('jwt', 'Plugin loaded.');
};
