'use strict';

const Joi = require('joi');

module.exports = function (bookshelf) {

    const proto = bookshelf.Model.prototype;

    bookshelf.Model = bookshelf.Model.extend({

        constructor: function () {

            proto.constructor.apply(this, arguments);

            if (typeof this.schema !== 'undefined') {
                this._schema = Joi.compile(this.schema);
                this.on('saving', this.validateValues);
            }

            if (typeof this.unique !== 'undefined') {
                this._unique = [];
                this.unique.forEach((constraint) => {

                    if (typeof constraint === 'string' && constraint !== this.idAttribute) {
                        this._unique.push([constraint]);
                    }
                    else if (Array.isArray(constraint) && constraint.length > 0) {
                        const fields = constraint.reduce((accumulator, field) => {

                            if (typeof field === 'string' && field !== this.idAttribute) {
                                accumulator.push(field);
                            }

                            return accumulator;
                        }, []);

                        this._unique.push(fields);
                    }
                });

                this.on('saving', this.validateUnique);
            }
        },

        validateValues: function (model, attrs, options) {

            return new Promise((resolve, reject) => {

                const attributes = {};
                if (options.method === 'insert') {
                    Object.assign(attributes, this.attributes);

                }
                else {
                    Object.assign(attributes, options.patch ? attrs : this.changed);
                    delete attributes[this.idAttribute];
                }

                // Validate the values according to the schema
                Joi.validate(
                    attributes,
                    this._schema, {
                        abortEarly: false,
                        context: options
                    },
                    (err) => {

                        if (err) {
                            this.set(this._previousAttributes, { silent: true });
                            return reject(err);
                        }

                        resolve();
                    }
                );
            });
        },

        validateUnique: function (model, attrs, options) {

            const self = this;

            const attributes = options.method === 'update' && options.patch ? attrs : self.attributes;

            // Determine which fields must be checked
            const fieldsToFetch = [];
            let fieldsToSelect = [];
            const uniqueFieldsToCheck = [];
            self._unique.forEach((fields) => {

                const constraintFieldsToFetch = [];

                let doCheck = false;
                let skipCheck = false;

                fields.forEach((field) => {

                    if (typeof attributes[field] !== 'undefined') {
                        doCheck = doCheck || (attributes[field] !== null);
                        skipCheck = skipCheck || (attributes[field] === null);
                        return;
                    }

                    constraintFieldsToFetch.push(field);
                });

                if (doCheck && !skipCheck) {
                    constraintFieldsToFetch.forEach((field) => {

                        if (!fieldsToFetch.includes(field)) {
                            fieldsToFetch.push(field);
                        }
                    });

                    fieldsToSelect = fieldsToSelect.concat(fields);

                    uniqueFieldsToCheck.push(fields);
                }
            });

            // Return immediately if there are no constraints to check
            if (uniqueFieldsToCheck.length === 0) {
                return;
            }

            const fetchMissing = () => {

                if (options.method === 'update' && fieldsToFetch.length > 0) {
                    return bookshelf
                        .knex(self.tableName)
                        .select(fieldsToFetch)
                        .where(self.idAttribute, self.id)
                        .then((result) => {

                            return result && result[0] || {};
                        });
                }

                return Promise.resolve({});
            };

            let uniqueConstraintsToCheck;

            return fetchMissing()
                .then((missingFields) => {

                    // Build constraints to check
                    uniqueConstraintsToCheck = uniqueFieldsToCheck.map((fields) => {

                        return fields.reduce((accumulator, field) => {

                            accumulator[field] = attributes[field] || missingFields[field];
                            return accumulator;
                        }, {});
                    });

                    const qb = bookshelf.knex(self.tableName);

                    if (self._transaction) {
                        qb.transacting(self._transaction);
                    }

                    if (options.method === 'insert') {
                        if (self.id) {
                            qb.where(self.idAttribute, self.id);
                        }

                        uniqueConstraintsToCheck.forEach((constraint) => {

                            qb.orWhere(constraint);
                        });
                    }
                    else {
                        if (self.id) {
                            qb.whereNot(self.idAttribute, self.id);
                        }

                        qb.andWhere(function () {

                            uniqueConstraintsToCheck.forEach((constraint) => {

                                this.orWhere(constraint);
                            });
                        });
                    }

                    return qb.select(fieldsToSelect);
                })
                .then((result) => {

                    const uniqueConstraintsViolated = [];
                    result.forEach((row) => {

                        uniqueConstraintsToCheck.forEach((constraint) => {

                            const isConstraintViolated = Object.keys(constraint).every((field) => {

                                return row[field] === constraint[field];
                            });

                            if (isConstraintViolated) {
                                uniqueConstraintsViolated.push(constraint);
                            }
                        });
                    });

                    if (uniqueConstraintsViolated.length > 0) {

                        let message = '';
                        const details = [];
                        uniqueConstraintsViolated.forEach((constraint) => {

                            const detail = {
                                context: {
                                    keys: Object.keys(constraint),
                                    values: Object.values(constraint)
                                },
                                message: `\"${Object.keys(constraint).join()}\" is not unique`,
                                path: Object.keys(constraint).join()
                            };

                            message = message.concat(`${message.length > 0 ? '. ' : ''}child \"${detail.path}\" fails because [${detail.message}]`);
                            details.push(detail);
                        });

                        const error = new Error(message);
                        error.name = 'NonUniqueError';
                        error.details = details;

                        throw error;
                    }
                });
        }
    });
};
