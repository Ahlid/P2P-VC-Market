const {Model} = require('objection');


class Token extends Model {

    static get tableName() {
        return 'Token';
    }

    static get idColumn() {
        return 'id';
    }

    static get jsonSchema() {
        return {
            type: "object",
            required: ['subject_type'],
            properties: {
                id: {type: "string", format: "uuid"},
                revoked: {type: 'boolean'},
                subject_type: {type: "string", minLength: 1, maxLength: 20},
                subject_id: {type: "string", format: "uuid"},
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
                    from: 'Token.subject_id',
                    to: 'User.id'
                }
            }
        }
    }
}

module.exports = Token;
