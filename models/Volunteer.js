const {Model} = require('objection');

class Volunteer extends Model {

    static get tableName() {
        return 'Volunteer';
    }

    static get idColumn() {
        return 'id';
    }

    static get jsonSchema() {
        return {
            type: "object",
            required: ['ip', 'port'],
            properties: {
                id: {type: "string", format: "uuid"},
                ip: {type: 'string', minLength: 1, maxLength: 255},
                state: {type: "string"},
                session_id: {type: "string", format: 'uuid'},
                machine_id: {type: "string", format: 'uuid'},
                stoped : {type: "boolean"},
                timeouted : {type: "boolean"},
            }
        }
    }

    static get relationMappings() {

        const Machine = require('./Machine');

        return {
            user: {
                relation: Model.BelongsToOneRelation,
                modelClass: Machine,
                join: {
                    from: 'Volunteer.machine_id',
                    to: 'Machine.id'
                }
            }
        }
    }
}

module.exports = Volunteer;
