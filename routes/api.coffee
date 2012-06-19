module.exports = (app) ->

  app.namespace '/dossiers', ->
    getDossier = require('./dossiers').getDossier
    app.get ':id', (req, res) ->
      getDossier(req.params.id, res)

  app.namespace '/queries', ->

    # Returns the list of saved queries
    app.get ':name', (req, res) ->
      res.json [
          _id: 1
          label: 'Tous les dossiers'
        ,
          _id: 2
          label: 'Cotisation non-payée'
      ]

    # Finds a saved query by it id and executes it.
    app.get ':id/results', (req, res) ->
      res.json [
          _id: 1
          label: 'M. Pierre Deschamps'
        ,
          _id: 2
          label: 'Dre. Rose Dubois'
      ]
        

