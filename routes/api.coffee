mongo = require 'mongodb'

module.exports = (app, dossiers, queries, messages) ->

  app.namespace '/dossiers', ->
    app.get ':id', (req, res) ->
      dossiers.getDossier(req.params.id, res)

  app.namespace '/queries', ->
    # Returns the list of saved queries
    app.get '/', (req, res) ->
      queries.getQueries(res)
    
    # Finds a saved query by it's id
    app.get ':id', (req, res) ->
      queries.getQuery(parseInt(req.params.id,10), res)

    # Finds a saved query by it's id and executes it.
    app.get ':id/results', (req, res) ->
      queries.getResults(req.params.id, req, res)

  app.namespace '/messages', ->
    app.get '/', (req, res) ->
      messages.getMessages(res)

    app.get ':id', (req, res) ->
      messages.getMessage(req.params.id, res)

    app.delete ':id', (req, res) ->
      messages.deleteMessage(req.params.id, res)

    app.post '/', (req, res) ->
      messages.postMessage(req, res)
