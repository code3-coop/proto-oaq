mongo = require 'mongodb'

module.exports = (app, db) ->

  app.namespace '/dossiers', ->
    dossiers = require('./dossiers')
    app.get ':id', (req, res) ->
      dossiers.getDossier(req.params.id, res, db)

  app.namespace '/queries', ->

    # Returns the list of saved queries
    app.get ':name', (req, res) ->
      res.json [
          _id: 1
          label: 'Nouveaux dossiers'
        ,
          _id: 2
          label: 'Cotisation non-payée'
        ,
          _id: 3
          label: 'Non-assuré'
      ]

    # Finds a saved query by it id and executes it.
    app.get ':id/results', (req, res) ->
      res.json [
          _id: "4fdf7eff7c5b1a000000005b"
          label: 'M. Pierre Deschamps'
        ,
          _id: "4fdf7eff7c5b1a0000000001"
          label: 'Dre. Rose Dubois'
        ,
          _id: "4fdf7eff7c5b1a00000000a1"
          label: 'M. Jean De la Montagne'
      ]
        

