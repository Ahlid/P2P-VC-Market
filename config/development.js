"use strict";

const Fs = require("fs");
const Path = require("path");

const getManifest = () => {
    const ca = Fs.readFileSync(Path.join(__dirname, "/ssl/intermediate.crt"));
    const cert = Fs.readFileSync(
        Path.join(__dirname, "/ssl/api.horizontalcities.com.crt")
    );
    const key = Fs.readFileSync(
        Path.join(__dirname, "/ssl/api.horizontalcities.com.key")
    );

    return {
        server: {
            app: {
                environment: "development",
                tls: {
                    ca,
                    cert,
                    key
                }
            },
            debug: {
                log: ["error"],
                request: ["error"]
            },
            port: 8082,
            routes: {
                cors: {
                    origin: ["*"],
                    additionalHeaders: ["headers"]
                }
            }
        },
        register: {
            plugins: [
                {
                    plugin: "good",
                    options: {
                        ops: {
                            interval: 15000
                        },
                        reporters: {
                            console: [
                                {
                                    module: "good-squeeze",
                                    name: "Squeeze",
                                    args: [
                                        {
                                            ops: "*",
                                            request: "*",
                                            response: "*",
                                            log: "*",
                                            error: "*"
                                        }
                                    ]
                                },
                                {
                                    module: "good-console"
                                },
                                "stdout"
                            ],
                            ops: [
                                {
                                    module: "good-squeeze",
                                    name: "Squeeze",
                                    args: [
                                        {
                                            ops: "*"
                                        }
                                    ]
                                },
                                {
                                    module: "good-squeeze",
                                    name: "SafeJson"
                                },
                                {
                                    module: "good-file",
                                    args: ["./logs/ops.log"]
                                }
                            ],
                            error: [
                                {
                                    module: "good-squeeze",
                                    name: "Squeeze",
                                    args: [
                                        {
                                            error: "*",
                                            log: ["error"]
                                        }
                                    ]
                                },
                                {
                                    module: "good-squeeze",
                                    name: "SafeJson"
                                },
                                {
                                    module: "good-file",
                                    args: ["./logs/error.log"]
                                }
                            ],
                            request: [
                                {
                                    module: "good-squeeze",
                                    name: "Squeeze",
                                    args: [
                                        {
                                            response: "*"
                                        }
                                    ]
                                },
                                {
                                    module: "good-squeeze",
                                    name: "SafeJson"
                                },
                                {
                                    module: "good-file",
                                    args: ["./logs/request.log"]
                                }
                            ]
                        }
                    }
                },
                {
                    plugin: "inert",
                    options: {}
                },
                {
                    plugin: "vision",
                    options: {}
                },
                {
                    plugin: "lout",
                    options: {}
                },
                {
                    plugin: "database",
                    options: {
                        knex: {
                            client: "pg",
                            connection: {
                                host: process.env.BD_HOST || "164.68.125.146",
                                port: process.env.BD_PORT || 5432,
                                user: process.env.BD_USER || "postgres",
                                password: process.env.BD_PASSWORD || "ist191062",
                                database: process.env.BD_DATABASE || "postgres",
                                charset: "utf8",
                                timezone: "UTC"
                            }
                        },
                        modelsPattern: "models/**.js",
                    }
                },
                {
                    plugin: "jwt",
                    options: {}
                }
            ]
        }
    };
};

module.exports = getManifest;
