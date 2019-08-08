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
internals.addMachine = async (request, h) => {

    try {

        // Create the user
        const machine = await request.server.plugins.database.Machine
            .query()
            .insert({
                name: request.payload.name,
                CPU: request.payload.CPU,
                disc: request.payload.disc,
                RAM: request.payload.RAM,
                price: request.payload.price,
                scj: 0,
                credibility: 0,
                user_id: request.auth.credentials.userId
            });

        // h
        return machine;
    } catch (err) {
        request.server.log('error', err);
        return Boom.boomify(err);
    }
};

internals.getMachine = async (request, h) => {

    try {

        // Create the user
        const machine = await request.server.plugins.database.Machine
            .query()
            .findById(request.params.id)
            .where({user_id: request.auth.credentials.userId});

        if (!machine) {
            return Boom.notFound("MACHINE NOT FOUND")
        }
        // h
        return machine;
    } catch (err) {
        request.server.log('error', err);
        return Boom.boomify(err);
    }
};

internals.listMachines = async (request, h) => {

    try {

        return await request.server.plugins.database.Machine
            .query()
            .where({user_id: request.auth.credentials.userId})
            .page((request.query.page - 1) ,  internals.rowsByPage);

    } catch (err) {
        request.server.log('error', err);
        return Boom.boomify(err);
    }
};


const routes = [
    {
        method: 'PUT',
        path: '/machine/',
        handler: internals.addMachine,
        config: {
            auth: 'user',
            validate: {
                payload: Joi.object({
                    name: Joi.string().required(),
                    CPU: Joi.number().min(1).required(),
                    disc: Joi.number().min(1).required(),
                    RAM: Joi.number().min(1).required(),
                    price: Joi.number().min(1).required()
                }),
                options: {abortEarly: false}
            },
            description: 'Lists users.',
            tags: ['User API'],

        }
    },
    {
        method: 'GET',
        path: '/machine/',
        handler: internals.listMachines,
        config: {
            auth: 'user',
            validate: {
                query: Joi.object({
                    page: Joi.number().min(1).required()
                }),
                options: {abortEarly: false}
            },
            description: 'Lists users machines.',
            tags: ['Machine API'],

        }
    },
    {
        method: 'GET',
        path: '/machine/{id}',
        handler: internals.getMachine,
        config: {
            auth: 'user',
            validate: {
                params: Joi.object({
                    id: Joi.string().uuid()
                }),
                options: {abortEarly: false}
            },
            description: 'Describe machine.',
            tags: ['Machine API'],

        }
    },
    ...require('./volunteer')
];

module.exports = routes;
