const SocketIO = require('socket.io');

const VolunteerManager = function (server) {

    this.io = SocketIO(server.listener);
    let that = this;

    this.io.on("connection", function (socket) {

        console.log('connected');
        socket.emit('update-volunteers', that.volunteers);

        // Do all the socket stuff here.

    });


    this.volunteers = {};
    this.server = server;
};

VolunteerManager.prototype.addVolunteer = function (volunteer) {
    this.volunteers[volunteer.id] = {lastHearthBeat: (new Date()).getTime(), ...volunteer};

    console.log(this.volunteers)

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