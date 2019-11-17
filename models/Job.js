const {Model} = require('objection');

class Job extends Model {

    static get tableName() {
        return 'Job';
    }

    static get idColumn() {
        return 'id';
    }

    static get jsonSchema() {
        return {
            type: "object",
            required: ['name', 'status','exec_file','name','price'],
            properties: {
                id: {type: "string", format: "uuid"},
                name: {type: 'string', minLength: 1, maxLength: 255},
                CPU: {type: "integer"},
                disc: {type: "integer"},
                RAM: {type: "integer"},
                price: {type: "integer"},
                deadline: {type: "timestamp"},
                init_time: {type: "timestamp"},
                exec_time: {type: "number"},
                r_data_path: {type: "string"},
                folder_path: {type: "string"},
                exec_file: {type: "string"},
                status: {type: "string"},
                partialResultsVars: {type: "array"},
                mean_up_time: {type: "number"},
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
                    from: 'Job.user_id',
                    to: 'Auth.id'
                }
            }
        }
    }
}

module.exports = Job;
