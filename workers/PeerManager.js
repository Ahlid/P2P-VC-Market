const SocketIO = require('socket.io');
const PEER = {
    HELLO: "HELLO",
    SET_LEADER: 'SET_LEADER',
    MARKET_PING: 'MARKET_PING',
    PING: 'P2P_PING',
    SET_NODE: 'SET_NODE',
    NEW_PEER: 'NEW_PEER',
};

const MARKET = {
    LEADER_HZ: "LEADER_HZ",
    SET_LEADER: 'SET_LEADER',
    PEER_CONNECTION: 'PEER_CONNECTION',
    PONG: 'P2P_PONG'
};


const PeerManager = function (server, timeout = 5000) {

    this.io = SocketIO(server.listener);
    let that = this;


    this.io.on("connection", (socket) => {
        this.bindSocket(socket);
        console.log("PEER CON");
        console.log(socket.id)
        socket.emit(PEER.HELLO, {"babe": 1});
        socket.on("disconnect", (socket) => {
            console.log("peer disconnect");
        });
    });


    this.sockets = {};
    this.leader = null;
    this.leaderLastHz = Date.now();
    this.server = server;
    this.intervalClean = setInterval(this.cleanInterval.bind(this), timeout)
};

PeerManager.prototype.bindSocket = function (socket) {


    socket.on(MARKET.PEER_CONNECTION, (data) => {
        console.log("peer conn: " + JSON.stringify(data));

        const {host, port} = data;

        socket.on(MARKET.PONG, (data) => {
            console.log("P")
            this.sockets[host + port] = {socket, ping: Date.now()};
        });

        socket.on(MARKET.SET_LEADER, (data) => {
            this.leader = host + port;
            this.leaderLastHz = Date.now();
        });

        if (this.sockets[data.host + data.port] && this.sockets[data.host + data.port].ping + 10000 > Date.now()) {
            if (this.leader != host + port) {
                this.markPeerAsNode(socket, data);
            } else if (this.leader == host + port) {
                this.markPeerAsLeader(socket, data);
            }
            return;
        }

        this.sockets[data.host + data.port] = {socket, ping: Date.now()};
        console.log(!!this.leader);
        if (this.leader) {
            this.markPeerAsNode(socket, data);
            this.sendPeerToLeader(data);
        } else {
            this.leader = host + port;
            this.markPeerAsLeader(socket, data);
        }

    });

    socket.on(MARKET.LEADER_HZ, (data) => {
        this.leaderLastHz = Date.now();
    });
};

PeerManager.prototype.sendHzToLeader = function () {
    if (this.leader) {
        console.log(this.leader + "    HZ");
        this.sockets[this.leader].socket.emit(PEER.MARKET_PING, {leaderLastHz: this.leaderLastHz});
    }
};

PeerManager.prototype.markPeerAsLeader = function (socket, info) {
    socket.emit(PEER.SET_LEADER);
};
PeerManager.prototype.markPeerAsNode = function (socket, info) {
    socket.emit(PEER.SET_NODE);
};

PeerManager.prototype.sendPeerToLeader = function (info) {
    if (this.leader) {
        console.log("send the new peer omg");
        //todo : implement
        this.sockets[this.leader].socket.emit('NEW_PEER', info);
    }
};

PeerManager.prototype.cleanInterval = function () {
    try {
        this.io.emit(PEER.PING);
        console.log(this.leaderLastHz)
        if ((this.leaderLastHz + 10000 < (new Date()).getTime())) {
            this.leader = null;
        } else {
            this.sendHzToLeader();
        }
    } catch (e) {

    }
};

exports.plugin = {
    name: 'Peer',
    version: '1.0.0',
    register: async function (server, options) {

        const volM = new PeerManager(server);

        server.expose("peerManager", volM);
    }
};