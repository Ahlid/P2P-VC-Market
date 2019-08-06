'use strict';

const AWS = require('aws-sdk');
const Crypto = require('crypto');
const Fs = require('fs');
const Path = require('path');

const AWSConfig = require('./aws/config.json');

const metaDataService = new AWS.MetadataService();

const getInstanceId = () => {

    return new Promise((resolve) => {

        metaDataService.request('/latest/meta-data/instance-id', (err, instanceId) => {

            if (err || !instanceId) {
                resolve(`r-${Crypto.randomBytes(8).toString('hex')}`);
                return;
            }

            resolve(instanceId);
        });
    });
};

const getManifest = async () => {

    const instanceId = await getInstanceId();

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
                                module: 'cwlogs-writable',
                                args: [
                                    {
                                        logGroupName: 'horizontalcities-api-ops',
                                        logStreamName: instanceId,
                                        cloudWatchLogsOptions: AWSConfig
                                    }
                                ]
                            }],
                            error: [{
                                module: 'good-squeeze',
                                name: 'Squeeze',
                                args: [{
                                    error: '*',
                                    log: ['error']
                                }]
                            }, {
                                module: 'cwlogs-writable',
                                args: [
                                    {
                                        logGroupName: 'horizontalcities-api-error',
                                        logStreamName: instanceId,
                                        cloudWatchLogsOptions: AWSConfig
                                    }
                                ]
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
                                module: 'cwlogs-writable',
                                args: [
                                    {
                                        logGroupName: 'horizontalcities-api-request',
                                        logStreamName: instanceId,
                                        cloudWatchLogsOptions: AWSConfig
                                    }
                                ]
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
                                host: 'horizontal-cities-db.cxjq3ke5wg01.eu-west-1.rds.amazonaws.com',
                                port: 5432,
                                user: 'horizontalcities',
                                password: '&FJ_@8nx?SEaUb#u',
                                database: 'horizontal_cities',
                                charset: 'utf8',
                                timezone: 'UTC'
                            }
                        },
                        modelsPattern: 'models/**.js'
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
                    register: 'mailer',
                    options: {
                        transporter: {
                            SES: new AWS.SES(Object.assign({}, AWSConfig, { apiVersion: '2010-12-01' }))
                        },
                        templatesDir: Path.join(__dirname, '../email-templates')
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
