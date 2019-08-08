const VolunteerManager = function (server, interval = 5000, timeout = 60 * 1000) {
    this.volunteers = {};
    this.server = server;
};

VolunteerManager.prototype.addVolunteer = function (volunteer) {
    this.volunteers[volunteer.id] = {lastHearthBeat: (new Date()).getTime(), ...volunteer};

    console.log(this.volunteers)
};


exports.plugin = {
    name: 'Volunteer',
    version: '1.0.0',
    register: async function (server, options) {

        const volM = new VolunteerManager(server);

        server.expose("volunteerManager", volM);
    }
};