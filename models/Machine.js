const {Model} = require('objection');

class Machine extends Model {

    static get tableName() {
        return 'Machine';
    }

    static get idColumn() {
        return 'id';
    }

    static get jsonSchema() {
        return {
            type: "object",
            required: ['CPU', 'disc','RAM','name','price'],
            properties: {
                id: {type: "string", format: "uuid"},
                name: {type: 'string', minLength: 1, maxLength: 255},
                CPU: {type: "integer"},
                disc: {type: "integer"},
                RAM: {type: "integer"},
                price: {type: "integer"},
                scj: {type: "integer"},
                credibility: {type: "number"},
                user_id: {type: "string", format: "uuid"}
            }
        }
    }

    static get relationMappings() {

        const User = require('./User');

        return {
            user: {
                relation: Model.BelongsToOneRelation,
                modelClass: User,
                join: {
                    from: 'Machine.user_id',
                    to: 'Auth.id'
                }
            }
        }
    }
}

module.exports = Machine;
