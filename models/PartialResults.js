const {Model} = require('objection');

class PartialResults extends Model {

    static get tableName() {
        return 'partial_results';
    }

    static get idColumn() {
        return 'id';
    }

    static get jsonSchema() {
        return {
            type: "object",
            properties: {
                id: {type: 'string', format: 'uuid'},
                name: {type: "string"},
                value: {type: "any"},
                job_id: {type: "string", format: 'uuid'},
                created_at: {type: "timestamp"},
            }
        }
    }

    static get relationMappings() {

        const Job = require('./Job');

        return {
            machine: {
                relation: Model.BelongsToOneRelation,
                modelClass: Job,
                join: {
                    from: 'partial_results.job_id',
                    to: 'Job.id'
                }
            }
        }
    }
}

module.exports = PartialResults;
