'use strict';

// Load modules
const Joi = require('joi');
const Boom = require('boom');

// Declare internals
const internals = {};

internals.issueToken = async (server, machineId) => {

    const token = await server.plugins.database.Token
        .query()
        .insert({
            subject_type: 'volunteer',
            subject_id: machineId
        });

    const options = {
        algorithm: 'RS256',
        issuer: 'urn:remotist.com',
        subject: token.subject_id,
        jwtid: token.id
    };

    // Issue a JSON Web Token
    return {token: server.plugins.jwt.sign({}, server.settings.app.tls.key, options), id: token.id};
};
/**
 * Registers a new user and issues a new JSON Web Token.
 *
 * @param request
 * @param h
 */
internals.startVolunteer = async (request, h) => {

    try {

        //ip, port, idMachine

        // Create the user
        const machine = await request.server.plugins.database.Machine
            .query()
            .findById(request.params.machineId);

        if (!machine) {
            return Boom.notFound();
        }

        /*
                //check if volunteer is already running
                const runningVolunteer = await request.server.plugins.database.Volunteer
                    .query()
                    .where({
                        machine_id: machine.id,
                        timeouted: false,
                        stoped: false
                    });

                if (runningVolunteer) {
                    return Boom.conflict("VOLUNTEER_ALREADY_RUNNING");
                }
        */
        // Issue a new JSON Web Token
        const token = await internals.issueToken(request.server, machine.id);

        const volunteer = await request.server.plugins.database.Volunteer
            .query()
            .insert({
                ip: request.info.remoteAddress,
                port: request.payload.port,
                machine_id: machine.id,
                session_id: token.id,
                state: 'FREE'
            });

        volunteer.machine = machine;

        request.server.plugins.Volunteer.volunteerManager.addVolunteer(volunteer);
        // Reply
        return {token: token.token};

    } catch (err) {
        request.server.log('error', err);
        return Boom.boomify(err);
    }
};


internals.healthzVolunteer = async (request, h) => {

    try {

        request.server.plugins.Volunteer.volunteerManager.healthzVolunteer(request.auth.credentials.id);


        return request.server.plugins.database.Hearthz
            .query()
            .insert({
                ip: request.info.remoteAddress,
                /*CPU: request.payload.CPU,
                disc: request.payload.disc,
                RAM: request.payload.RAM,
                jobs: request.payload.jobs,
                network: request.payload.network,*/
                CPU: Math.floor(Math.random()*100000),
                disc: Math.floor(Math.random()*100000),
                RAM: Math.floor(Math.random()*100000),
                jobs: Math.floor(Math.random()*100),
                network: Math.floor(Math.random()*10000000),
                machine_id: request.auth.credentials.userId,
                session_id: request.auth.credentials.id
            });

    } catch (err) {
        request.server.log('error', err);
        return Boom.boomify(err);
    }
};


internals.setVolunteerState = async (request, h) => {

    try {

        request.server.plugins.Volunteer.volunteerManager.setVolunteerState(request.auth.credentials.id, request.payload.state);

        return 1;

    } catch (err) {
        request.server.log('error', err);
        return Boom.boomify(err);
    }
};

const routes = [
    {
        method: 'POST',
        path: '/machine/{machineId}/startVolunteer',
        handler: internals.startVolunteer,
        config: {
            auth: 'user',
            validate: {
                params: Joi.object({
                    machineId: Joi.string().uuid().required(),
                }),
                payload: Joi.object({
                    port: Joi.number().min(1).required(),
                }),
                options: {abortEarly: false}
            },
            description: 'Starts machine as volunteer. Returns volunteer session token',
            tags: ['User API'],

        }
    },
    {
        method: 'GET',
        path: '/volunteer/healthz',
        handler: internals.healthzVolunteer,
        config: {
            auth: 'volunteer',
            description: 'Healthz for volunteer',
            tags: ['User API'],

        }
    },
    {
        method: 'POST',
        path: '/volunteer/setState',
        handler: internals.setVolunteerState,
        config: {
            auth: 'volunteer',
            description: 'Healthz for volunteer',
            tags: ['User API'],

        }
    }
];

module.exports = routes;
