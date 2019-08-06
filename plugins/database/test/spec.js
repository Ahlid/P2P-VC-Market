'use strict';

// Load modules
const chai = require('chai'), should = chai.should();
const Hapi = require('hapi');
const Joi = require('joi');

// Load Chai plugins
chai.use(require('chai-as-promised'));

// Load Database plugin (test target)
const plugin = require('../');

const internals = {};

internals.options = {
    knex: {
        client: 'sqlite',
        connection: {
            filename: './data.db'
        },
        useNullAsDefault: true
    }
};

internals.schemas = {
    none: {
        tableName: 'test'
    },
    simple: {
        tableName: 'test',
        schema: Joi.object({
            id: Joi.forbidden(),
            foo: Joi.string(),
            bar: Joi.string()
        })
    },
    requiredOnInsert: {
        tableName: 'test',
        schema: Joi.object({
            id: Joi.forbidden(),
            foo: Joi.string().when('$method', {
                is: 'insert',
                then: Joi.required()
            }),
            bar: Joi.string()
        })
    },
    forbiddenOnInsert: {
        tableName: 'test',
        schema: Joi.object({
            id: Joi.forbidden(),
            foo: Joi.string().when('$method', {
                is: 'insert',
                then: Joi.forbidden()
            }),
            bar: Joi.string()
        })
    },
    optionalOnInsert: {
        tableName: 'test',
        schema: Joi.object({
            id: Joi.forbidden(),
            foo: Joi.string().when('$method', {
                is: 'insert',
                then: Joi.optional()
            }),
            bar: Joi.string().when('$method', {
                is: 'insert',
                then: Joi.optional()
            })
        })
    },
    requiredOnUpdate: {
        tableName: 'test',
        schema: Joi.object({
            id: Joi.forbidden(),
            foo: Joi.string().when('$method', {
                is: 'update',
                then: Joi.required()
            }),
            bar: Joi.string()
        })
    },
    forbiddenOnUpdate: {
        tableName: 'test',
        schema: Joi.object({
            id: Joi.forbidden(),
            foo: Joi.string().when('$method', {
                is: 'update',
                then: Joi.forbidden()
            }),
            bar: Joi.string()
        })
    },
    optionalOnUpdate: {
        tableName: 'test',
        schema: Joi.object({
            id: Joi.forbidden(),
            foo: Joi.string().when('$method', {
                is: 'update',
                then: Joi.optional()
            }),
            bar: Joi.string().when('$method', {
                is: 'update',
                then: Joi.optional()
            })
        })
    },
    unique: {
        tableName: 'test',
        schema: Joi.object({
            id: Joi.forbidden(),
            foo: Joi.string(),
            bar: Joi.string()
        }),
        unique: ['foo', 'bar']
    },
    uniqueComposite: {
        tableName: 'test',
        schema: Joi.object({
            id: Joi.forbidden(),
            foo: Joi.string(),
            bar: Joi.string()
        }),
        unique: [['foo', 'bar']]
    }
};

describe('Database Plugin', function () {

    let server;

    beforeEach('start the hapi server', function () {

        server = new Hapi.Server({
            host: 'localhost'
        });

        return server.start().should.be.fulfilled;
    });

    afterEach('stop the hapi server', function () {

        return server.stop().should.be.fulfilled;
    });

    describe('#register', function () {

        it('should register the database plugin', function () {

            return server.register({
                plugin,
                options: internals.options
            }).should.be.fulfilled;
        });

        it('should expose the bookshelf instance', function () {

            return server.register({
                plugin,
                options: internals.options
            }).then(() => {
                should.exist(server.plugins.database.bookshelf);
            });
        });

        it('should register and expose plain object models', function () {

            return server.register({
                plugin,
                options: Object.assign({}, internals.options, { modelsPattern: 'test/models/*.js' })
            }).then(() => {
                should.exist(server.plugins.database.Object);
                should.exist(server.plugins.database.bookshelf.model('Object'));
            });
        });

        it('should register and expose collections of plain object models', function () {

            return server.register({
                plugin,
                options: Object.assign({}, internals.options, { modelsPattern: 'test/models/*.js' })
            }).then(() => {
                should.exist(server.plugins.database.ObjectCollection);
                should.exist(server.plugins.database.bookshelf.collection('ObjectCollection'));
            });
        });

        it('should register and expose constructed models', function () {

            return server.register({
                plugin,
                options: Object.assign({}, internals.options, { modelsPattern: 'test/models/*.js' })
            }).then(() => {
                should.exist(server.plugins.database.Function);
                should.exist(server.plugins.database.bookshelf.model('Function'));
            });
        });

        it('should register and expose collections of constructed models', function () {

            return server.register({
                plugin,
                options: Object.assign({}, internals.options, { modelsPattern: 'test/models/*.js' })
            }).then(() => {
                should.exist(server.plugins.database.FunctionCollection);
                should.exist(server.plugins.database.bookshelf.collection('FunctionCollection'));
            });
        });
    });

    describe('validator plugin', function () {

        beforeEach('register the database plugin', function () {

            return server.register({
                plugin,
                options: internals.options
            }).then(() => {
                return server.plugins.database.bookshelf.knex.schema.createTableIfNotExists('test', (table) => {
                    table.increments('id').primary();
                    table.string('foo');
                    table.string('bar');
                }).then(() => {
                    return server.plugins.database.bookshelf.knex('test').truncate();
                })
            });
        });

        afterEach('cleanup', function () {

            return server.plugins.database.bookshelf.knex('test');
        });

        it('should not validate a model with no schema', function () {

            const Test = server.plugins.database.bookshelf.Model.extend(internals.schemas.none);
            return new Test().save().should.be.fulfilled;

        });

        it('should validate a model with valid attributes', function () {

            const Test = server.plugins.database.bookshelf.Model.extend(internals.schemas.simple);
            return new Test().save({ foo: 'test', bar: 'test' }).should.be.fulfilled;
        });

        it('should not validate a model with invalid attributes', function () {

            const Test = server.plugins.database.bookshelf.Model.extend(internals.schemas.simple);
            return new Test()
                .save({ foo: 0, bar: 'test' })
                .should.be.rejected
                .then((err) => {
                    err.name.should.equal('ValidationError');
                });
        });

        it('should insert a model if all required attributes are present', function () {

            const Test = server.plugins.database.bookshelf.Model.extend(internals.schemas.requiredOnInsert);
            return new Test().save({ foo: 'test', bar: 'test' }).should.be.fulfilled;
        });

        it('should not insert a model if any required attribute is absent', function () {

            const Test = server.plugins.database.bookshelf.Model.extend(internals.schemas.requiredOnInsert);
            return new Test().save({ bar: 'test' })
                .should.be.rejected
                .then((err) => {
                    err.name.should.equal('ValidationError');
                });
        });

        it('should insert a model if all forbidden attributes are absent', function () {

            const Test = server.plugins.database.bookshelf.Model.extend(internals.schemas.forbiddenOnInsert);
            return new Test().save({ bar: 'test' }).should.be.fulfilled;
        });

        it('should not insert a model if any forbidden attribute is present', function () {

            const Test = server.plugins.database.bookshelf.Model.extend(internals.schemas.forbiddenOnInsert);
            return new Test().save({ foo: 'test', bar: 'test' })
                .should.be.rejected
                .then((err) => {
                    err.name.should.equal('ValidationError');
                });
        });

        it('should insert a model regardless of the presence of optional attributes', function () {

            const Test = server.plugins.database.bookshelf.Model.extend(internals.schemas.optionalOnInsert);
            return new Test().save({ foo: 'test' }).should.be.fulfilled;
        });

        it('should update a model if all required attributes are present', function () {

            const Test = server.plugins.database.bookshelf.Model.extend(internals.schemas.requiredOnUpdate);
            return Promise.all([
                new Test({ foo: 'test1', bar: 'test1' })
                    .save()
                    .then((model) => {
                        return model.save({ foo: 'test2' })
                            .should.be.fulfilled.then(() => {
                                model.get('foo').should.equal('test2');
                                model.get('bar').should.equal('test1');
                                return model.refresh().then((databaseUpdatedModel) => {
                                    databaseUpdatedModel.get('foo').should.equal('test2');
                                    databaseUpdatedModel.get('bar').should.equal('test1');
                                });
                            });
                    }),
                new Test({ foo: 'test1', bar: 'test1' })
                    .save()
                    .then((model) => {
                        return new Test({ id: model.get('id'), foo: 'test2' })
                            .save()
                            .should.be.fulfilled.then((localNewModel) => {
                                localNewModel.get('foo').should.equal('test2');
                                return model.refresh().then((databaseUpdatedModel) => {
                                    databaseUpdatedModel.get('foo').should.equal('test2');
                                    databaseUpdatedModel.get('bar').should.equal('test1');
                                });
                            });
                    }),
                new Test({ foo: 'test1', bar: 'test1' })
                    .save()
                    .then((model) => {
                        return new Test({ id: model.get('id'), bar: 'test2' })
                            .save({ foo: 'test2' })
                            .should.be.fulfilled.then((localNewModel) => {
                                localNewModel.get('foo').should.equal('test2');
                                return model.refresh().then((databaseUpdatedModel) => {
                                    databaseUpdatedModel.get('foo').should.equal('test2');
                                    databaseUpdatedModel.get('bar').should.equal('test2');
                                });
                            });
                    })
                ,
                new Test({ foo: 'test1', bar: 'test1' })
                    .save()
                    .then((model) => {
                        return new Test({ id: model.get('id'), bar: 'test2' })
                            .save({ foo: 'test2' }, { patch: true })
                            .should.be.fulfilled.then((localNewModel) => {
                                localNewModel.get('foo').should.equal('test2');
                                return model.refresh().then((databaseUpdatedModel) => {
                                    databaseUpdatedModel.get('foo').should.equal('test2');
                                    databaseUpdatedModel.get('bar').should.equal('test1');
                                });
                            });
                    })
            ]);
        });

        it('should not update a model if any required attribute is absent', function () {

            const Test = server.plugins.database.bookshelf.Model.extend(internals.schemas.requiredOnUpdate);
            return Promise.all([
                new Test({ foo: 'test1', bar: 'test1' })
                    .save()
                    .then((model) => {
                        return model.save({ bar: 'test2' })
                            .should.be.rejected
                            .then((err) => {
                                err.name.should.equal('ValidationError');

                                model.get('foo').should.equal('test1');
                                model.get('bar').should.equal('test1');

                                return model.refresh().then((databaseUpdatedModel) => {
                                    databaseUpdatedModel.get('foo').should.equal('test1');
                                    databaseUpdatedModel.get('bar').should.equal('test1');
                                });
                            });
                    }),
                new Test({ foo: 'test1', bar: 'test1' })
                    .save()
                    .then((model) => {
                        return new Test({ id: model.get('id'), bar: 'test2' })
                            .save()
                            .should.be.rejected
                            .then((err) => {
                                err.name.should.equal('ValidationError');

                                return model.refresh().then((databaseUpdatedModel) => {
                                    databaseUpdatedModel.get('foo').should.equal('test1');
                                    databaseUpdatedModel.get('bar').should.equal('test1');
                                });
                            });
                    }),
                new Test({ foo: 'test1', bar: 'test1' })
                    .save()
                    .then((model) => {
                        return new Test({ id: model.get('id') })
                            .save({ bar: 'test2' })
                            .should.be.rejected
                            .then((err) => {
                                err.name.should.equal('ValidationError');

                                return model.refresh().then((databaseUpdatedModel) => {
                                    databaseUpdatedModel.get('foo').should.equal('test1');
                                    databaseUpdatedModel.get('bar').should.equal('test1');
                                });
                            });
                    })
                ,
                new Test({ foo: 'test1', bar: 'test1' })
                    .save()
                    .then((model) => {
                        return new Test({ id: model.get('id'), foo: 'test2' })
                            .save({ bar: 'test2' }, { patch: true })
                            .should.be.rejected
                            .then((err) => {
                                err.name.should.equal('ValidationError');

                                return model.refresh().then((databaseUpdatedModel) => {
                                    databaseUpdatedModel.get('foo').should.equal('test1');
                                    databaseUpdatedModel.get('bar').should.equal('test1');
                                });
                            });
                    })
            ]);
        });

        it('should update a model if all forbidden attributes are absent', function () {

            const Test = server.plugins.database.bookshelf.Model.extend(internals.schemas.forbiddenOnUpdate);
            return Promise.all([
                new Test({ foo: 'test1', bar: 'test1' })
                    .save()
                    .then((model) => {
                        return model.save({ bar: 'test2' })
                            .should.be.fulfilled.then(() => {
                                model.get('foo').should.equal('test1');
                                model.get('bar').should.equal('test2');
                                return model.refresh().then((databaseUpdatedModel) => {
                                    databaseUpdatedModel.get('foo').should.equal('test1');
                                    databaseUpdatedModel.get('bar').should.equal('test2');
                                });
                            });
                    }),
                new Test({ foo: 'test1', bar: 'test1' })
                    .save()
                    .then((model) => {
                        return new Test({ id: model.get('id'), bar: 'test2' })
                            .save()
                            .should.be.fulfilled.then((localNewModel) => {
                                localNewModel.get('bar').should.equal('test2');
                                return model.refresh().then((databaseUpdatedModel) => {
                                    databaseUpdatedModel.get('foo').should.equal('test1');
                                    databaseUpdatedModel.get('bar').should.equal('test2');
                                });
                            });
                    }),
                new Test({ foo: 'test1', bar: 'test1' })
                    .save()
                    .then((model) => {
                        return new Test({ id: model.get('id') })
                            .save({ bar: 'test2' })
                            .should.be.fulfilled.then((localNewModel) => {
                                localNewModel.get('bar').should.equal('test2');
                                return model.refresh().then((databaseUpdatedModel) => {
                                    databaseUpdatedModel.get('foo').should.equal('test1');
                                    databaseUpdatedModel.get('bar').should.equal('test2');
                                });
                            });
                    })
                ,
                new Test({ foo: 'test1', bar: 'test1' })
                    .save()
                    .then((model) => {
                        return new Test({ id: model.get('id'), foo: 'test2' })
                            .save({ bar: 'test2' }, { patch: true })
                            .should.be.fulfilled.then((localNewModel) => {
                                localNewModel.get('bar').should.equal('test2');
                                return model.refresh().then((databaseUpdatedModel) => {
                                    databaseUpdatedModel.get('foo').should.equal('test1');
                                    databaseUpdatedModel.get('bar').should.equal('test2');
                                });
                            });
                    })
            ]);
        });

        it('should not update a model if any forbidden attribute is present', function () {

            const Test = server.plugins.database.bookshelf.Model.extend(internals.schemas.forbiddenOnUpdate);
            return Promise.all([
                new Test({ foo: 'test1', bar: 'test1' })
                    .save()
                    .then((model) => {
                        return model.save({ foo: 'test2' })
                            .should.be.rejected
                            .then((err) => {
                                err.name.should.equal('ValidationError');

                                model.get('foo').should.equal('test1');
                                model.get('bar').should.equal('test1');

                                return model.refresh().then((databaseUpdatedModel) => {
                                    databaseUpdatedModel.get('foo').should.equal('test1');
                                    databaseUpdatedModel.get('bar').should.equal('test1');
                                });
                            });
                    }),
                new Test({ foo: 'test1', bar: 'test1' })
                    .save()
                    .then((model) => {
                        return new Test({ id: model.get('id'), foo: 'test2' })
                            .save()
                            .should.be.rejected
                            .then((err) => {
                                err.name.should.equal('ValidationError');

                                return model.refresh().then((databaseUpdatedModel) => {
                                    databaseUpdatedModel.get('foo').should.equal('test1');
                                    databaseUpdatedModel.get('bar').should.equal('test1');
                                });
                            });
                    }),
                new Test({ foo: 'test1', bar: 'test1' })
                    .save()
                    .then((model) => {
                        return new Test({ id: model.get('id') })
                            .save({ foo: 'test2' })
                            .should.be.rejected
                            .then((err) => {
                                err.name.should.equal('ValidationError');

                                return model.refresh().then((databaseUpdatedModel) => {
                                    databaseUpdatedModel.get('foo').should.equal('test1');
                                    databaseUpdatedModel.get('bar').should.equal('test1');
                                });
                            });
                    })
                ,
                new Test({ foo: 'test1', bar: 'test1' })
                    .save()
                    .then((model) => {
                        return new Test({ id: model.get('id') })
                            .save({ foo: 'test2' }, { patch: true })
                            .should.be.rejected
                            .then((err) => {
                                err.name.should.equal('ValidationError');

                                return model.refresh().then((databaseUpdatedModel) => {
                                    databaseUpdatedModel.get('foo').should.equal('test1');
                                    databaseUpdatedModel.get('bar').should.equal('test1');
                                });
                            });
                    })
            ]);
        });

        it('should update a model regardless of the presence of optional attributes', function () {

            const Test = server.plugins.database.bookshelf.Model.extend(internals.schemas.optionalOnUpdate);
            return Promise.all([
                new Test({ foo: 'test1', bar: 'test1' })
                    .save()
                    .then((model) => {
                        return model.save({ foo: 'test2' })
                            .should.be.fulfilled.then(() => {
                                model.get('foo').should.equal('test2');
                                model.get('bar').should.equal('test1');
                                return model.refresh().then((databaseUpdatedModel) => {
                                    databaseUpdatedModel.get('foo').should.equal('test2');
                                    databaseUpdatedModel.get('bar').should.equal('test1');
                                });
                            });
                    }),
                new Test({ foo: 'test1', bar: 'test1' })
                    .save()
                    .then((model) => {
                        return new Test({ id: model.get('id'), foo: 'test2' })
                            .save()
                            .should.be.fulfilled.then((localNewModel) => {
                                localNewModel.get('foo').should.equal('test2');
                                return model.refresh().then((databaseUpdatedModel) => {
                                    databaseUpdatedModel.get('foo').should.equal('test2');
                                    databaseUpdatedModel.get('bar').should.equal('test1');
                                });
                            });
                    }),
                new Test({ foo: 'test1', bar: 'test1' })
                    .save()
                    .then((model) => {
                        return new Test({ id: model.get('id') })
                            .save({ foo: 'test2' })
                            .should.be.fulfilled.then((localNewModel) => {
                                localNewModel.get('foo').should.equal('test2');
                                return model.refresh().then((databaseUpdatedModel) => {
                                    databaseUpdatedModel.get('foo').should.equal('test2');
                                    databaseUpdatedModel.get('bar').should.equal('test1');
                                });
                            });
                    })
                ,
                new Test({ foo: 'test1', bar: 'test1' })
                    .save()
                    .then((model) => {
                        return new Test({ id: model.get('id') })
                            .save({ foo: 'test2' }, { patch: true })
                            .should.be.fulfilled.then((localNewModel) => {
                                localNewModel.get('foo').should.equal('test2');
                                return model.refresh().then((databaseUpdatedModel) => {
                                    databaseUpdatedModel.get('foo').should.equal('test2');
                                    databaseUpdatedModel.get('bar').should.equal('test1');
                                });
                            });
                    })
            ]);
        });

        it('should insert a model if all unique constraints are satisfied', function () {

            const Test = server.plugins.database.bookshelf.Model.extend(internals.schemas.unique);
            return new Test()
                .save({ foo: 'test1', bar: 'test1' })
                .then(() => {
                    return new Test().save({ foo: 'test2', bar: 'test2' }).should.be.fulfilled;
                });
        });

        it('should not insert a model if any unique constraint is violated', function () {

            const Test = server.plugins.database.bookshelf.Model.extend(internals.schemas.unique);
            return new Test()
                .save({ foo: 'test1', bar: 'test1' })
                .then(() => {
                    return new Test()
                        .save({ foo: 'test1', bar: 'test2' })
                        .should.be.rejected
                        .then((err) => {
                            err.name.should.equal('NonUniqueError');
                        });
                });
        });

        it('should update a model if all unique constraints are satisfied', function () {

            const Test = server.plugins.database.bookshelf.Model.extend(internals.schemas.unique);
            return Promise.all([
                new Test().save({ foo: 'test1', bar: 'test1' }),
                new Test().save({ foo: 'test2', bar: 'test2' }),
                new Test().save({ foo: 'test3', bar: 'test3' }),
                new Test().save({ foo: 'test4', bar: 'test4' })
            ]).then((models) => {
                return Promise.all([
                    models[0].save({ foo: 'test1' }).should.be.fulfilled,
                    models[1].save({ foo: 'test2_other' }).should.be.fulfilled,
                    new Test({ id: models[2].get('id') }).save({ foo: 'test3_other' }).should.be.fulfilled,
                    new Test({
                        id: models[2].get('id'),
                        bar: 'test4'
                    }).save({ foo: 'test3_other' }, { patch: true }).should.be.fulfilled
                ]);
            });
        });

        it('should not update a model if any unique constraint is violated', function () {

            const Test = server.plugins.database.bookshelf.Model.extend(internals.schemas.unique);
            return Promise.all([
                new Test().save({ foo: 'test1', bar: 'test1' }),
                new Test().save({ foo: 'test2', bar: 'test2' }),
                new Test().save({ foo: 'test3', bar: 'test3' }),
                new Test().save({ foo: 'test4', bar: 'test4' })
            ]).then((models) => {
                return Promise.all([
                    models[0]
                        .save({ foo: 'test4' })
                        .should.be.rejected
                        .then((err) => {
                            err.name.should.equal('NonUniqueError');
                        }),
                    new Test({ id: models[1].get('id') })
                        .save({ foo: 'test4' })
                        .should.be.rejected
                        .then((err) => {
                            err.name.should.equal('NonUniqueError');
                        }),
                    new Test({
                        id: models[2].get('id'),
                        bar: 'test4'
                    })
                        .save({ foo: 'test3_other' })
                        .should.be.rejected
                        .then((err) => {
                            err.name.should.equal('NonUniqueError');
                        })
                ]);
            });
        });

        it('should insert a model if all composite unique constraints are satisfied', function () {

            const Test = server.plugins.database.bookshelf.Model.extend(internals.schemas.uniqueComposite);
            return new Test()
                .save({ foo: 'test1', bar: 'test1' })
                .then(() => {
                    return Promise.all([
                        new Test().save({ foo: 'test1', bar: 'test2' }).should.be.fulfilled,
                        new Test().save({ foo: 'test2', bar: 'test1' }).should.be.fulfilled,
                        new Test().save({ foo: 'test2', bar: 'test2' }).should.be.fulfilled
                    ]);
                });
        });

        it('should not insert a model if any composite unique constraint is violated', function () {

            const Test = server.plugins.database.bookshelf.Model.extend(internals.schemas.uniqueComposite);
            return new Test()
                .save({ foo: 'test1', bar: 'test1' })
                .then(() => {
                    return new Test()
                        .save({ foo: 'test1', bar: 'test1' })
                        .should.be.rejected
                        .then((err) => {
                            err.name.should.equal('NonUniqueError');
                        });
                });
        });

        it('should update a model if all composite unique constraints are satisfied', function () {

            const Test = server.plugins.database.bookshelf.Model.extend(internals.schemas.uniqueComposite);
            return Promise.all([
                new Test().save({ foo: 'test1', bar: 'test1' }),
                new Test().save({ foo: 'test2', bar: 'test2' }),
                new Test().save({ foo: 'test3', bar: 'test3' }),
                new Test().save({ foo: 'test4', bar: 'test4' })
            ]).then((models) => {
                return Promise.all([
                    models[0].save({ foo: 'test1' }).should.be.fulfilled,
                    models[1].save({ foo: 'test2_other' }).should.be.fulfilled,
                    new Test({ id: models[2].get('id') }).save({ foo: 'test3_other' }).should.be.fulfilled,
                    new Test({
                        id: models[2].get('id'),
                        bar: 'test4'
                    }).save({ foo: 'test3_other' }, { patch: true }).should.be.fulfilled
                ]);
            });
        });

        it('should not update a model if any composite unique constraint is violated', function () {

            const Test = server.plugins.database.bookshelf.Model.extend(internals.schemas.uniqueComposite);
            return Promise.all([
                new Test().save({ foo: 'test', bar: 'test1' }),
                new Test().save({ foo: 'test', bar: 'test2' }),
                new Test().save({ foo: 'test', bar: 'test3' }),
                new Test().save({ foo: 'test', bar: 'test4' })
            ]).then((models) => {
                return Promise.all([
                    models[0]
                        .save({ bar: 'test4' })
                        .should.be.rejected
                        .then((err) => {
                            err.name.should.equal('NonUniqueError');
                        }),
                    new Test({ id: models[1].get('id') })
                        .save({ bar: 'test4' })
                        .should.be.rejected
                        .then((err) => {
                            err.name.should.equal('NonUniqueError');
                        }),
                    new Test({
                        id: models[2].get('id'),
                        bar: 'test4'
                    })
                        .save()
                        .should.be.rejected
                        .then((err) => {
                            err.name.should.equal('NonUniqueError');
                        })
                ]);
            });
        });
    });
});
