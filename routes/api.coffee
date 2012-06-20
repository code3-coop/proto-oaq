mongo = require 'mongodb'

module.exports = (app, db) ->

  app.namespace '/dossiers', ->
    dossiers = require('./dossiers')
    app.get ':id', (req, res) ->
      dossiers.getDossier(req.params.id, res, db)

  app.namespace '/queries', ->
    queries =  require('./queries')
    # Returns the list of saved queries
    app.get ':name', (req, res) ->
      queries.getQueries(req.params.name, res, db)

    # Finds a saved query by it id and executes it.
    app.get ':id/results', (req, res) ->
      queries.getResults(req.params.id, res, db)
