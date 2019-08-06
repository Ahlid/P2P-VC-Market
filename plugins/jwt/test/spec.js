'use strict';

// Load modules
const chai = require('chai'), should = chai.should();
const request = require('request');
const Hapi = require('hapi');

// Load Chai plugins
chai.use(require('chai-subset'));
chai.use(require('chai-as-promised'));

// Load JSON Web Token plugin (test target)
const plugin = require('../');

// Declare internals
const internals = {
    jwt: {
        payload: {
            validate: true
        },
        secret: 'secret',
        options: {
            subject: 'test'
        }
    }
};

describe('JSON Web Token Plugin', function () {
    let server;

    beforeEach('start the hapi server', function () {
        server = new Hapi.Server({ host: 'localhost' });
        return server.start().should.be.fulfilled;
    });

    afterEach('stop a hapi server', function () {
        return server.stop().should.be.fulfilled;
    });

    describe('#register', function () {

        it('should register the jwt plugin', function () {
            return server.register({
                plugin
            }).should.be.fulfilled;
        });

        it('should register the authentication scheme', function () {
            return server.register({
                plugin
            }).then(() => {
                (() => {
                    server.auth.strategy('test1', 'jwt', {
                        jwt: {
                            secretOrPublicKey: 'secret'
                        }
                    });
                }).should.not.throw();

                (() => {
                    server.auth.strategy('test2', 'jwt');
                }).should.throw();
            });
        });

        it('should expose the sign function', function () {
            return server.register({
                plugin
            }).then(() => {
                should.exist(server.plugins.jwt.sign);
            });
        });
    });

    describe('#internals.scheme', function () {

        beforeEach('register the jwt plugin and configure the server', function () {
            return server.register({
                plugin
            }).then(() => {
                server.auth.strategy('jwt', 'jwt', {
                    jwt: {
                        secretOrPublicKey: internals.jwt.secret
                    }
                });

                server.route({
                    method: 'GET',
                    path: '/',
                    config: {
                        auth: 'jwt',
                        handler: (request) => {
                            return request.auth;
                        }
                    }
                });
            });
        });

        it('should authorize a request with a valid token on the header', function (done) {
            // Sign JSON Web Token
            const token = server.plugins.jwt.sign(internals.jwt.payload, internals.jwt.secret, internals.jwt.options);

            request({
                method: 'GET',
                uri: 'http://localhost:' + server.info.port,
                auth: {
                    bearer: token
                }
            }, (error, response, body) => {
                if (error) {
                    return done(error);
                }

                JSON.parse(body).should.containSubset({
                    artifacts: internals.jwt.payload
                });
                done();
            });
        });

        it('should authorize a request with a valid token on the query string', function (done) {
            // Sign JSON Web Token
            const token = server.plugins.jwt.sign(internals.jwt.payload, internals.jwt.secret, internals.jwt.options);

            request({
                method: 'GET',
                uri: 'http://localhost:' + server.info.port + '?token=' + token
            }, (error, response, body) => {
                if (error) {
                    return done(error);
                }

                JSON.parse(body).should.containSubset({
                    artifacts: internals.jwt.payload
                });
                done();
            });
        });

        it('should authorize a request with a valid token on the cookies', function (done) {
            // Sign JSON Web Token
            const token = server.plugins.jwt.sign(internals.jwt.payload, internals.jwt.secret, internals.jwt.options);

            const jar = request.jar();
            const cookie = request.cookie('token=' + token);
            jar.setCookie(cookie, 'http://localhost');

            request({
                method: 'GET',
                uri: 'http://localhost:' + server.info.port,
                jar: jar
            }, (error, response, body) => {
                if (error) {
                    return done(error);
                }

                JSON.parse(body).should.containSubset({
                    artifacts: internals.jwt.payload
                });
                done();
            });
        });

        it('should not authorize a request with a missing token', function (done) {
            request({
                method: 'GET',
                uri: 'http://localhost:' + server.info.port,
                auth: {
                    bearer: ''
                }
            }, (error, response, body) => {
                if (error) {
                    return done(error);
                }

                response.statusCode.should.eql(401);
                JSON.parse(body).should.eql({
                    statusCode: 401,
                    error: 'Unauthorized',
                    message: 'Missing authentication'
                });
                done();
            });
        });

        it('should not authorize a request with an invalid token', function (done) {
            // Sign JSON Web Token (invalid signature)
            const token = server.plugins.jwt.sign(internals.jwt.payload, 'wrong_secret', internals.jwt.options);

            request({
                method: 'GET',
                uri: 'http://localhost:' + server.info.port,
                auth: {
                    bearer: token
                }
            }, (error, response, body) => {
                if (error) {
                    return done(error);
                }

                JSON.parse(body).should.containSubset({
                    statusCode: 401,
                    error: 'Unauthorized',
                    message: 'invalid signature'
                });
                done();
            });
        });
    });

    describe('#internals.scheme with validate', function () {

        beforeEach('register plugin and configure server', function () {
            return server.register({
                plugin
            }).then(() => {
                server.auth.strategy('jwt', 'jwt', {
                    jwt: {
                        secretOrPublicKey: internals.jwt.secret,
                        validateFunc: (request, payload) => {
                            if (typeof payload.validate !== 'undefined') {
                                return {
                                    isValid: payload.validate,
                                    credentials: payload
                                };
                            } else {
                                throw new Error('Invalid payload');
                            }
                        }
                    }
                });

                server.route({
                    method: 'GET',
                    path: '/',
                    config: {
                        auth: 'jwt',
                        handler: (request) => {
                            return request.auth;
                        }
                    }
                });
            });
        });

        it('should authorize a request that passes validation', function (done) {
            // Payload
            const payload = { validate: true };

            // Sign JSON Web Token
            const token = server.plugins.jwt.sign(payload, internals.jwt.secret, internals.jwt.options);

            request({
                method: 'GET',
                uri: 'http://localhost:' + server.info.port,
                auth: {
                    bearer: token
                }
            }, (error, response, body) => {
                if (error) {
                    return done(error);
                }

                JSON.parse(body).should.containSubset({
                    credentials: payload,
                    artifacts: payload
                });
                done();
            });
        });

        it('should not authorize a request that fails validation', function (done) {
            // Payload
            const payload = { validate: false };

            // Sign JSON Web Token
            const token = server.plugins.jwt.sign(payload, internals.jwt.secret, internals.jwt.options);

            request({
                method: 'GET',
                uri: 'http://localhost:' + server.info.port,
                auth: {
                    bearer: token
                }
            }, (error, response, body) => {
                if (error) {
                    return done(error);
                }

                JSON.parse(body).should.containSubset({
                    statusCode: 401,
                    error: 'Unauthorized',
                    message: 'Missing authentication'
                });
                done();
            });
        });

        it('should not authorize a request that causes a validate function error', function (done) {
            // Sign JSON Web Token
            const token = server.plugins.jwt.sign({}, internals.jwt.secret, internals.jwt.options);

            request({
                method: 'GET',
                uri: 'http://localhost:' + server.info.port,
                auth: {
                    bearer: token
                }
            }, (error, response, body) => {
                if (error) {
                    return done(error);
                }

                JSON.parse(body).should.containSubset({
                    statusCode: 500,
                    error: 'Internal Server Error'
                });
                done();
            });
        });
    });
});
