'use strict';

const Glue = require('glue');
const Manifest = require('./manifest');

const options = {
    relativeTo: __dirname
};

(async () => {

    try {
        const manifest = await Manifest.get();
        const server = await Glue.compose(manifest, options);
        await server.start();

        server.route({
            method: 'GET',
            path: '/healthz',
            handler: (request, h) => {

                console.log("ok");
                return "ok";
            }
        });


        //Auth
        server.auth.strategy('user', 'jwt', {
            jwt: {
                secretOrPublicKey: server.settings.app.tls.cert,
                options: {
                    algorithms: ['RS256'],
                    issuer: 'urn:remotist.com'
                },
                validateFunc: async (request, payload) => {

                    try {

                        const token = await request.server.plugins.database.Token
                            .query()
                            .findById(payload.jti)

                        if (!token) {
                            throw new Error("TOKEN_NOT_FOUND")
                        }

                        return {
                            isValid: true,
                            credentials: {
                                id: token.id,
                                userId: token.subject_id,
                                subject_type: token.subject_type
                            }
                        };

                    } catch (e) {

                        return {
                            isValid: false,
                            credentials: {}
                        };
                    }

                }
            }
        });

        //controllers
        server.route(require('./controllers/'));

        console.log("SERVER RUNNING")

    } catch (err) {
        console.log(err);
    }
})();
