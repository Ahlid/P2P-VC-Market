'use strict';

const Fs = require('fs');
const Path = require('path');

const getManifest = () => {

    const ca = Fs.readFileSync(Path.join(__dirname, '/ssl/intermediate.crt'));
    const cert = Fs.readFileSync(Path.join(__dirname, '/ssl/api.horizontalcities.com.crt'));
    const key = Fs.readFileSync(Path.join(__dirname, '/ssl/api.horizontalcities.com.key'));

    return {
        server: {
            app: {
                environment: 'production',
                tls: {
                    ca,
                    cert,
                    key
                }
            },
            cache: {
                engine: 'catbox-memory',
                allowMixedContent: true
            },
            debug: {
                log: ['error'],
                request: ['error']
            }
        },
        connections: [
            {
                port: 8081,
                labels: ['api']
            }
        ],
        registrations: [
            {
                plugin: {
                    register: 'good',
                    options: {
                        ops: {
                            interval: 60000
                        },
                        reporters: {
                            ops: [{
                                module: 'good-squeeze',
                                name: 'Squeeze',
                                args: [{
                                    ops: '*'
                                }]
                            }, {
                                module: 'good-squeeze',
                                name: 'SafeJson'
                            }, {
                                module: 'good-file',
                                args: ['./logs/ops.log']
                            }],
                            error: [{
                                module: 'good-squeeze',
                                name: 'Squeeze',
                                args: [{
                                    error: '*',
                                    log: ['error']
                                }]
                            }, {
                                module: 'good-squeeze',
                                name: 'SafeJson'
                            }, {
                                module: 'good-file',
                                args: ['./logs/error.log']
                            }],
                            request: [{
                                module: 'good-squeeze',
                                name: 'Squeeze',
                                args: [{
                                    response: '*'
                                }]
                            }, {
                                module: 'good-squeeze',
                                name: 'SafeJson'
                            }, {
                                module: 'good-file',
                                args: ['./logs/request.log']
                            }]
                        }
                    }
                },
                options: {}
            },
            {
                plugin: {
                    register: 'poop',
                    options: {
                        logPath: './logs/poop.log'
                    }
                },
                options: {}
            },
            {
                plugin: {
                    register: 'inert',
                    options: {}
                },
                options: {}
            },
            {
                plugin: {
                    register: 'vision',
                    options: {}
                },
                options: {}
            },
            {
                plugin: {
                    register: 'database',
                    options: {
                        knex: {
                            client: 'pg',
                            connection: {
                                host: process.env.BD_HOST ,
                                port: process.env.BD_PORT ,
                                user: process.env.BD_USER ,
                                password: process.env.BD_PASSWORD ,
                                database: process.env.BD_DATABASE ,
                                charset: "utf8",
                                timezone: "UTC"
                            }
                        },
                        modelsPattern: 'models/**.js',
                        objectionModelsPattern: 'objection-models/**.js'
                    }
                },
                options: {}
            },
            {
                plugin: {
                    register: 'jwt',
                    options: {}
                },
                options: {}
            },
            {
                plugin: {
                    register: 'sockets',
                    options: {
                        connection: 'api'
                    }
                },
                options: {}
            },
            {
                plugin: {
                    register: 'msgpack',
                    options: {}
                },
                options: {}
            }
        ]
    };
};

module.exports = getManifest;
