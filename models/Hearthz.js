const {Model} = require('objection');

class Hearthz extends Model {

    static get tableName() {
        return 'hearthz';
    }

    static get idColumn() {
        return ['timestamp', 'machine_id']; //composed key?
    }

    static get jsonSchema() {
        return {
            type: "object",
            properties: {
                ip: {type: 'string', minLength: 1, maxLength: 255},
                CPU: {type: "integer"},
                disc: {type: "integer"},
                RAM: {type: "integer"},
                jobs: {type: "integer"},
                network: {type: "number"},
                machine_id: {type: "string", format: "uuid"},
                session_id: {type: "string", format: "uuid"},
                timestamp: {type: "timestamp"},
            }
        }
    }

    static get relationMappings() {

        const Machine = require('./Machine');

        return {
            machine: {
                relation: Model.BelongsToOneRelation,
                modelClass: Machine,
                join: {
                    from: 'Hearthz.machine_id',
                    to: 'Volunteer.id'
                }
            }
        }
    }
}

module.exports = Hearthz;
