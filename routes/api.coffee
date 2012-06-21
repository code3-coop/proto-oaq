mongo = require 'mongodb'

module.exports = (app, dossiers, queries) ->

  app.namespace '/dossiers', ->
    app.get ':id', (req, res) ->
      dossiers.getDossier(req.params.id, res)

  app.namespace '/queries', ->
    # Returns the list of saved queries
    app.get ':name', (req, res) ->
      queries.getQueries(req.params.name, res)

    # Finds a saved query by it id and executes it.
    app.get ':id/results', (req, res) ->
      queries.getResults(req.params.id, res)
