const {Model} = require('objection');

class Peer extends Model {

    static get tableName() {
        return 'peer';
    }

    static get idColumn() {
        return ['peer_id'];
    }

    static get jsonSchema() {
        return {
            type: "object",
            properties: {
                peer_id: {type: "string", format: "uuid"},
                super_peer_id: {type: "string", format: "uuid"},
                cpu: {type: "integer"},
                port: {type: "integer"},
                host: {type: "string"},
                disc: {type: "integer"},
                ram: {type: "integer"},
                credits: {type: "integer"},
            }
        }
    }
}

module.exports = Peer;
