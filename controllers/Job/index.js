'use strict';

// Load modules
const Joi = require('joi');
const Boom = require('boom');
const mv = require('mv');

// Declare internals
const internals = {};

internals.rowsByPage = 25;
internals.partialResults = {};

/**
 * Registers a new user and issues a new JSON Web Token.
 *
 * @param request
 * @param h
 */
internals.addJob = async (request, h) => {
    console.log(request.payload)
    try {
        const job = await request.server.plugins.database.Job
            .query()
            .insert({
                name: request.payload.name[0],
                CPU: request.payload.CPU[0] * 1,
                disc: request.payload.disc[0] * 1,
                RAM: request.payload.RAM[0] * 1,
                price: request.payload.price[0] * 1,
                user_id: request.auth.credentials.userId,
                deadline: request.payload.deadline[0],
                exec_file: request.payload.exec_file[0],
                partialResultsVars: request.payload.partialResultsVars,
                status: 'UNBOUND',
                mean_up_time: 0,
            });

        return job;

    } catch (err) {
        request.server.log('error', err);
        return Boom.boomify(err);
    }
};

internals.getJob = async (request, h) => {

    try {

        // Create the user
        const Job = await request.server.plugins.database.Job
            .query()
            .findById(request.params.id)
            .where({user_id: request.auth.credentials.userId});

        if (!Job) {
            return Boom.notFound("JOB NOT FOUND")
        }
        // h
        return Job;
    } catch (err) {
        request.server.log('error', err);
        return Boom.boomify(err);
    }
};

internals.abortJob = async (request, h) => {

    try {

        // Create the user
        const Job = await request.server.plugins.database.Job
            .query()
            .findById(request.params.id)
            .where({user_id: request.auth.credentials.userId})
            .patch({status: 'ABORTED'});

        if (!Job) {
            return Boom.notFound("JOB NOT FOUND")
        }
        // h
        return Job;
    } catch (err) {
        request.server.log('error', err);
        return Boom.boomify(err);
    }
};

internals.listJobs = async (request, h) => {

    try {

        return await request.server.plugins.database.Job
            .query()
            .where({user_id: request.auth.credentials.userId})
            .page((request.query.page - 1), internals.rowsByPage);

    } catch (err) {
        request.server.log('error', err);
        return Boom.boomify(err);
    }
};

internals.uploadJobData = async (request, h) => {

    try {
        const data = request.payload;
        const dest = process.cwd() + `/files/data/${request.params.id}_input.RData`;

        await move(data.path, dest);

        return await request.server.plugins.database.Job
            .query()
            .where({user_id: request.auth.credentials.userId})
            .patchAndFetchById(request.params.id, {r_data_path: dest});

    } catch (err) {
        request.server.log('error', err);
        return Boom.boomify(err);
    }
};

internals.uploadJobOutput = async (request, h) => {

    try {
        const data = request.payload;
        const dest = process.cwd() + `/files/output/${request.params.id}_out.RData`;

        await move(data.path, dest);

        return 1;

    } catch (err) {
        request.server.log('error', err);
        return Boom.boomify(err);
    }
};

internals.uploadCodePath = async (request, h) => {

    try {
        const data = request.payload;
        const dest = process.cwd() + `/files/code/${request.params.id}.zip`;

        await move(data.path, dest);

        const job = await request.server.plugins.database.Job
            .query()
            .where({user_id: request.auth.credentials.userId})
            .patchAndFetchById(request.params.id, {folder_path: dest});

        await request.server.plugins.Job.jobManager.addJob(job);

        return job;

    } catch (err) {
        request.server.log('error', err);
        return Boom.boomify(err);
    }
};

internals.getJobData = async (request, h) => {

    try {

        const dest = process.cwd() + `/files/data/${request.params.id}_input.RData`;
        return h.file(dest);

    } catch (err) {
        request.server.log('error', err);
        return Boom.boomify(err);
    }
};

internals.getJobCode = async (request, h) => {

    try {

        const dest = process.cwd() + `/files/code/${request.params.id}.zip`;
        return h.file(dest);

    } catch (err) {
        request.server.log('error', err);
        return Boom.boomify(err);
    }
};

internals.getJobOutput = async (request, h) => {

    try {

        const dest = process.cwd() + `/files/output/${request.params.id}_out.RData`;
        return h.file(dest);

    } catch (err) {
        request.server.log('error', err);
        return Boom.boomify(err);
    }
};

internals.registerError = async (request, h) => {

    try {

        console.log(request.payload)
        return "";

    } catch (err) {
        request.server.log('error', err);
        return Boom.boomify(err);
    }
};

internals.registerPartialResult = async (request, h) => {

    try {
        console.log(request.payload);
        internals.partialResults[request.params.variable] = request.payload;
        await request.server.plugins.database.PartialResults
            .query()
            .insert({
                name: request.params.variable,
                value: request.payload,
                job_id: request.params.id
            });
        return "";

    } catch (err) {
        request.server.log('error', err);
        return Boom.boomify(err);
    }
};

internals.getPartialResult = async (request, h) => {

    try {

        const partialResult = await request.server.plugins.database.PartialResults
            .query()
            .orderBy('created_at', 'desc')
            .findOne({
                job_id: request.params.id,
                name: request.params.variable
            });

        if (!partialResult)
            return Boom.notFound();

        return partialResult.value;

    } catch (err) {
        request.server.log('error', err);
        return Boom.boomify(err);
    }
};

internals.getPartialResultHistory = async (request, h) => {

    try {

        const partialResult = await request.server.plugins.database.PartialResults
            .query()
            .orderBy('created_at', 'desc')
            .where(
                'job_id', request.params.id
            ).andWhere(
                'name', request.params.variable
            );

        if (!partialResult)
            return Boom.notFound();

        const result = partialResult.map(p => p.value);
       // return result;
        return JSON.stringify(result);

    } catch (err) {
        request.server.log('error', err);
        return Boom.boomify(err);
    }
};

function move(source, dest) {
    return new Promise(function (resolve, reject) {
        mv(source, dest, function (err) {

            if (err) {
                return reject(err);
            }
            resolve();

        });
    });
}

const routes = [
    {
        method: 'PUT',
        path: '/job/',
        handler: internals.addJob,
        config: {
            auth: 'user',
            /* validate: {
                 payload: Joi.object({
                     name: Joi.string().required(),
                     exec_file: Joi.string().required(),
                     CPU: Joi.number().min(1).optional(),
                     disc: Joi.number().min(1).optional(),
                     RAM: Joi.number().min(1).optional(),
                     price: Joi.number().min(1).required(),
                     deadline: Joi.string().optional()
                 }),
                 options: {abortEarly: false}
             },*/
            description: 'Lists users.',
            tags: ['User API'],

        }
    },
    {
        method: 'GET',
        path: '/job/',
        handler: internals.listJobs,
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
        path: '/job/{id}',
        handler: internals.getJob,
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
    {
        method: 'DELETE',
        path: '/job/{id}',
        handler: internals.abortJob,
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
    {
        method: 'POST',
        path: '/job/{id}/data',
        handler: internals.uploadJobData,
        config: {
            auth: 'user',
            payload: {
                parse: false,
                output: 'file',
                allow: "application/octet-stream",
                maxBytes: 100000000000,
                timeout: false,

            },
            description: 'Registers a new client.',
            tags: ['Admin', 'API']
        }
    },
    {
        method: 'POST',
        path: '/job/{id}/output',
        handler: internals.uploadJobOutput,
        config: {
            payload: {
                parse: false,
                output: 'file',
                allow: "application/octet-stream",
                maxBytes: 100000000000,
                timeout: false,

            },
            description: 'Registers a new client.',
            tags: ['Admin', 'API']
        }
    },
    {
        method: 'GET',
        path: '/job/{id}/data',
        handler: internals.getJobData,
        config: {
            description: 'Registers a new client.',
            tags: ['Admin', 'API']
        }
    },
    {
        method: 'GET',
        path: '/job/{id}/code',
        handler: internals.getJobCode,
        config: {
            description: 'Registers a new client.',
            tags: ['Admin', 'API']
        }
    },
    {
        method: 'GET',
        path: '/job/{id}/output',
        handler: internals.getJobOutput,
        config: {
            description: 'Registers a new client.',
            tags: ['Admin', 'API']
        }
    },
    {
        method: 'POST',
        path: '/job/{id}/code',
        handler: internals.uploadCodePath,
        config: {
            auth: 'user',
            payload: {
                parse: false,
                output: 'file',
                allow: "application/octet-stream",
                maxBytes: 100000000000,
                timeout: false,

            },
            description: 'Registers a new client.',
            tags: ['Admin', 'API']
        }
    },
    {
        method: 'POST',
        path: '/job/{id}/error',
        handler: internals.registerError,
        config: {
            description: 'Registers a new client.',
            tags: ['Admin', 'API']
        }
    }, {
        method: 'POST',
        path: '/job/{id}/partialResults/{variable}',
        handler: internals.registerPartialResult,
        config: {
            payload: {
                parse: false,
                output: 'data',
                allow: null,
                maxBytes: 100000000000,
                timeout: false,
            },
            description: 'Registers a new client.',
            tags: ['Admin', 'API']
        }
    }, {
        method: 'GET',
        path: '/job/{id}/partialResults/{variable}',
        handler: internals.getPartialResult,
        config: {
            description: 'Registers a new client.',
            tags: ['Admin', 'API']
        }
    }, {
        method: 'GET',
        path: '/job/{id}/partialResults/{variable}/history',
        handler: internals.getPartialResultHistory,
        config: {
            description: 'Registers a new client.',
            tags: ['Admin', 'API']
        }
    },
];

module.exports = routes;
