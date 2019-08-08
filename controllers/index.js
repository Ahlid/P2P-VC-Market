const Auth = require('./Auth');
const User = require('./User');
const Machine = require('./Machine');
const Job = require('./Job');


module.exports = [
    ...Auth,
    ...User,
    ...Machine,
    ...Job
];