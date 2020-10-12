const amqp = require('amqplib');

const JobManager = function (queue = 'jobs', host = 'amqp://164.68.125.146/') {
    this.init(queue, host)
    this.queue = queue;
};

JobManager.prototype.init = async function (queue, host) {
    const connection = await amqp.connect(host);

    const channel = await connection.createChannel();

    await channel.assertQueue(queue, {
        durable: false
    });

    this.channel = channel;
};

JobManager.prototype.addJob = function (job) {
    this.channel.sendToQueue(this.queue, Buffer.from(JSON.stringify(job)));
};

exports.plugin = {
    name: 'Job',
    version: '1.0.0',
    register: async function (server, options) {

        const jobM = new JobManager();

        server.expose("jobManager", jobM);
    }
};