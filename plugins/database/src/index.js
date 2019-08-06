'use strict';

// Load modules
const Path = require('path');
const Hoek = require('hoek');
const Joi = require('joi');
const Knex = require('knex');
const Glob = require('glob');
const {Model} = require('objection');

// Declare internals
const internals = {};

// Schemas
internals.schemas = {
    options: Joi.object({
        knex: Joi.object({
            client: Joi.string().required(),
            connection: Joi.alternatives().try(Joi.object(), Joi.string()).required(),
            debug: Joi.boolean().optional()
        }).unknown(),
        modelsPattern: Joi.string(),
        objectionModelsPattern: Joi.string().optional()
    })
};

// Defaults
internals.defaults = {
    options: {}
};

// Server 'onPreStop' event listener: Closes the database connections pool.
internals.onPreStop = async (server) => {

    try {
        await internals.knex.destroy();

        server.log('database', 'Database connection closed.');
    } catch (err) {

        server.log(['error', 'database'], err.message);
    }
};

/**
 * Plugin name.
 *
 * @type {string}
 */
exports.name = 'database';

/**
 * Plugin package.
 */
exports.pkg = require('../package.json');

/**
 * Registers the plugin.
 *
 * @param server Server object.
 * @param options Options object.
 */
exports.register = async (server, options) => {

    // Validate options
    Joi.assert(options, internals.schemas.options);

    const settings = Hoek.applyToDefaults(internals.defaults, options);

    try {
        internals.knex = Knex(settings.knex);
    } catch (err) {
        server.log(['error', 'database'], 'Unable to initialize Knex.');
        throw err;
    }

    //objection
    Model.knex(internals.knex);
    internals.objection = Model;

    // Close all database connections when the hapi server stops
    server.ext('onPreStop', internals.onPreStop);

    //register objection models
    if (settings.modelsPattern) {
        await new Promise((resolve, reject) => {

            Glob(settings.modelsPattern, (err, files) => {

                if (err) {
                    server.log(['error', 'database'], err.message);
                    reject(err);
                    return;
                }

                const objection = {};

                files.forEach((file) => {

                    // Determine the model and collection names
                    const parsedPath = Path.parse(file);
                    const modelName = parsedPath.name[0].toUpperCase() + parsedPath.name.substr(1);
                    const model = require(Path.resolve(file));

                    server.expose(modelName, model);


                });

                resolve();
            });
        });
    }

    server.log('database', 'Plugin loaded.');
};
