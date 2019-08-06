const {Model} = require('objection');

const unique = require('objection-unique')({
    fields: ['email'],
    identifiers: ['email']
});
const Password = require('objection-password')();

class User extends Password(unique(Model)) {

    static get tableName() {
        return 'User';
    }

    static get idColumn() {
        return 'id';
    }

    static get jsonSchema() {
        return {
            type: "object",
            required: ['email', 'password',],
            properties: {
                id: {type: "string", format: "uuid"},
                email: {type: 'string', format: 'email', minLength: 5, maxLength: 255}, //todo check email format
                credits: {type: "number"},
            }
        }
    }


    static get relationMappings() {

        const Token = require('./Token');

        return {
            tokens: {
                relation: Model.HasManyRelation,
                modelClass: Token,
                join: {
                    from: 'User.id',
                    to: 'Token.subject_id'
                }
            }
        }
    }
}

module.exports = User;
