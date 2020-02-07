const SocketIO = require('socket.io');

const VolunteerManager = function (server, timeout = 5000) {

    this.io = SocketIO(server.listener);
    let that = this;

    this.io.on("connection", function (socket) {

        console.log('connected');
        socket.emit('update-volunteers', that.volunteers);
        socket.emit('hello', {"babe": 1});

    });

    this.volunteers = {};
    this.server = server;
    this.intervalClean = setInterval(this.cleanInterval.bind(this), timeout)
};

VolunteerManager.prototype.addVolunteer = function (volunteer) {
    this.volunteers[volunteer.session_id] = {lastHearthBeat: (new Date()).getTime(), ...volunteer};

    console.log(this.volunteers)

    this.io.emit('update-volunteers', this.volunteers);

};

VolunteerManager.prototype.healthzVolunteer = function (id) {
    this.volunteers[id] = {...this.volunteers[id], lastHearthBeat: (new Date()).getTime()};
    this.io.emit('update-volunteers', this.volunteers);

};

VolunteerManager.prototype.setVolunteerState = function (id, state) {
    this.volunteers[id] = {...this.volunteers[id], lastHearthBeat: (new Date()).getTime(), state: state};
    this.io.emit('update-volunteers', this.volunteers);

};

VolunteerManager.prototype.cleanInterval = function () {

    for (let key in this.volunteers) {
        let volunteer = this.volunteers[key];
        if (volunteer.lastHearthBeat < (new Date()).getTime() - 1000 * 60) {
            delete this.volunteers[key];
        } //1min
    }

    this.io.emit('update-volunteers', this.volunteers);

};

exports.plugin = {
    name: 'Volunteer',
    version: '1.0.0',
    register: async function (server, options) {

        const volM = new VolunteerManager(server);

        server.expose("volunteerManager", volM);
    }
};