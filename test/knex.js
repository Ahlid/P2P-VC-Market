const {Model} = require('objection');
const Knex = require('knex');

// Initialize knex.
const knex = Knex({
    client: "pg",
    connection: {
        host: "192.168.1.169",
        port: 5433,
        user: "postgres",
        password: "password",
        database: "postgres",
        charset: "utf8",
        timezone: "UTC"
    }
});

// Give the knex instance to objection.
Model.knex(knex);
console.log("ok")

knex.raw('select * from public.Job').then(r => {
    console.log(r)
});