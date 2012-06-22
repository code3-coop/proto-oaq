mongo = require 'mongodb'

module.exports = (app, dossiers, queries) ->

  app.namespace '/dossiers', ->
    app.get ':id', (req, res) ->
      dossiers.getDossier(req.params.id, res)

  app.namespace '/queries', ->
    # Returns the list of saved queries
    app.get '/', (req, res) ->
      queries.getQueries(res)
    
    # Free-text query
    app.get 'free/:queryParams', (req, res) ->
      queries.getTextQueryResults(req.params.queryParams, res)

    # Finds a saved query by it's id
    app.get ':id', (req, res) ->
      queries.getQuery(parseInt(req.params.id,10), res)

    # Finds a saved query by it's id and executes it.
    app.get ':id/results', (req, res) ->
      queries.getResults(req.params.id, res)
