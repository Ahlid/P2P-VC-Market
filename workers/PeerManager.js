const SocketIO = require('socket.io');
const PEER = {
    HELLO: "HELLO",
    SET_LEADER: 'SET_LEADER',
    MARKET_PING: 'MARKET_PING',
    PING: 'P2P_PING',
    SET_NODE: 'SET_NODE',
    NEW_PEER: 'NEW_PEER',
    REQUEST_JOB_ASSIGN: 'REQUEST_JOB_ASSIGN',
    SEND_SESSION_TOKEN: 'SEND_SESSION_TOKEN',
    LEADER_LIVE_PROOF: 'LEADER_LIFE_PROOF'
};
const SUPER_NODES_SIZE = 5;
const MARKET = {
    LEADER_HZ: "LEADER_HZ",
    SET_LEADER: 'SET_LEADER',
    PEER_CONNECTION: 'PEER_CONNECTION',
    PONG: 'P2P_PONG',
    JOB_ASSIGNED: 'JOB_ASSIGNED',
    SEND_PEERS_STATE: 'SEND_PEERS_STATE',
    LEADER_LIVE_PROOF: 'LEADER_LIFE_PROOF',
    REQUEST_LEADER_EMERGE: 'REQUEST_LEADER_EMERGE'
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

    this.currentLiveLeaderRequests = {};
    this.sockets = {};
    this.leader = null;
    this.leaderLastHz = Date.now();
    this.server = server;
    this.timeout = timeout;
    this.intervalClean = setInterval(this.cleanInterval.bind(this), timeout)
};

PeerManager.prototype.bindSocket = function (socket) {


    socket.on(MARKET.PEER_CONNECTION, async (data) => {
        console.log("peer conn: " + JSON.stringify(data));

        const {password, machineId, machineToken, port} = data;
        const email = data.username;
        data.id = machineId;
        data.metric = Math.random();

        if (!machineToken) {

            const result = {}
            const authResponse = await this.server.inject({
                method: 'POST',
                url: '/user/login',
                payload: {email, password}
            });


            const machineAuthResponse = await this.server.inject({
                method: 'POST',
                url: `/machine/${machineId}/startVolunteer`,
                payload: {port},
                headers: {
                    Authorization: 'Bearer ' + authResponse.result.token
                }
            });

            if (machineAuthResponse.statusCode = 200 && authResponse.statusCode == 200) {

                result.token = authResponse.result.token;
                result.machineToken = authResponse.result.token;
                socket.emit(PEER.SEND_SESSION_TOKEN, result);
            }
        } else {

            console.log("Reconnect from machine " + machineId)
        }


        this.bindSocketEvents(socket, data);

    });


    socket.on(MARKET.LEADER_HZ, (data) => {
        this.leaderLastHz = Date.now();
    });

    socket.on('disconnect', () => {
        //todo check if is leader, remove from list
    })
};

PeerManager.prototype.bindSocketEvents = function (socket, data) {
    const {host, port} = data;
    const socketId = data.id;

    socket.on(MARKET.PONG, (data) => {
        this.sockets[socketId] = {socket, ping: Date.now()};
    });

    socket.on(MARKET.SET_LEADER, (data) => {
        this.leader = socketId;
        this.leaderLastHz = Date.now();
    });

    socket.on(MARKET.REQUEST_LEADER_EMERGE, this.onRequestLeaderEmerge(socket, socketId));
    socket.on(MARKET.LEADER_LIVE_PROOF, this.onLeaderLiveProof(socket));

    socket.on(MARKET.SEND_PEERS_STATE, async (data) => {
        console.log("===========================================================");
        console.log(data);
        const {Peer} = this.server.plugins.database;
        await Peer.query().delete().where({super_peer_id: data.id})
        const bulkData = data.peersData.map(dataItem => {
            return {
                disk: dataItem.disk * 1,
                port: dataItem.port * 1,
                credits: dataItem.credits * 1,
                host: dataItem.host,
                cpu: dataItem.cpu * 1,
                peer_id: dataItem.id,
                super_peer_id: data.id,
                ram: dataItem.ram * 1
            }
        });
        await Peer.query().insert(bulkData);
        console.log("===========================================================");
    });

    if (this.sockets[socketId] && this.sockets[socketId].ping + 10000 > Date.now()) {
        if (this.leader != socketId) {
            this.markPeerAsNode(socket, data);
        } else if (this.leader == socketId) {
            this.markPeerAsLeader(socket, data);
        }
        return;
    }

    this.sockets[socketId] = {socket, ping: Date.now(), data};
    console.log(!!this.leader);
    if (this.leader) {
        this.markPeerAsNode(socket, data);
        this.sendPeerToLeader(data);
    } else {
        this.leader = socketId;
        this.markPeerAsLeader(socket, data);
    }
};

PeerManager.prototype.sendHzToLeader = function () {
    if (this.leader) {
        console.log(this.leader + "    HZ");
        console.log(Object.keys(this.sockets))
        this.sockets[this.leader].socket.emit(PEER.MARKET_PING, {leaderLastHz: this.leaderLastHz});
    }
};

PeerManager.prototype.markPeerAsLeader = function (socket, info) {
    socket.emit(PEER.SET_LEADER, {superNodeSize: SUPER_NODES_SIZE});
};

PeerManager.prototype.markPeerAsNode = function (socket, info) {
    socket.emit(PEER.SET_NODE);
};

PeerManager.prototype.sendPeerToLeader = function (info) {
    if (this.leader) {
        console.log("send the new peer omg");
        this.sockets[this.leader].socket.emit('NEW_PEER', info);
    }
};

PeerManager.prototype.onRequestLeaderEmerge = function (socket, socketId) {
    return (data) => {
        //leader socket id in sockets list
        const leaderSocketId = this.leader;

        //just to make sure
        if (socketId === leaderSocketId) {
            return;
        }

        //no current leader, set him as leader and end it here
        if (!leaderSocketId) {
            this.leader = socketId;
        } else {
            const leaderSocket = this.sockets[leaderSocketId]; //get leader socket
            const requestId = Date.now() + socketId; //generate id for live proof request
            this.currentLiveLeaderRequests[requestId] = false; //add it to current live proof requests
            leaderSocket.emit(PEER.LEADER_LIVE_PROOF, {requestId}); //request live proof to leader

            //wait
            setTimeout(() => {
                //check if the leader did answer
                if (this.currentLiveLeaderRequests[requestId]) {
                    this.sockets[socketId].emit(PEER.SET_NODE); //if he did, the node that requested to be leader should not be leader but a simple node
                }
                //clean memory
                delete this.currentLiveLeaderRequests[requestId];
            }, this.timeout)
        }
    }
};

PeerManager.prototype.onLeaderLiveProof = function (socket) {
    return (data) => {
        this.currentLiveLeaderRequests[data.requestId] = data.response == 1;
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