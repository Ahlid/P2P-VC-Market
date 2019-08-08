const JobManager = function (server, interval = 5000) {
    this.interval = interval;
    this.jobs = {};
    this.started = false;
    this.server = server;
};

JobManager.prototype.addJob = function (job) {
    this.jobs[job.id] = job;
};

JobManager.prototype.startJob = function (jobId, volunteerId) {
    this.jobs[jobId] = {volunteerId: volunteerId, ...this.jobs[jobId]};
};

JobManager.prototype.completeJob = function (jobId, volunteerId) {

};

JobManager.prototype.abortJob = function (jobId, volunteerId) {

};

JobManager.prototype.run = function () {
    console.log("run")
};

JobManager.prototype.start = function () {

    if (!this.started) {
        setInterval(this.run, this.interval)
    }

    this.started = true;

};

exports.plugin = {
    name: 'Job',
    version: '1.0.0',
    register: async function (server, options) {

        const jobM = new JobManager(server);
        jobM.start();

        server.expose("jobManager", jobM);
    }
};