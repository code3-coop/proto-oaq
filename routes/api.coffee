mongo = require 'mongodb'

module.exports = (app, db) ->

  app.namespace '/dossiers', ->

    app.get ':id', (req, res) ->
      id = mongo.ObjectID.createFromHexString req.params.id
      db.collection 'intervenants', (err, collection) ->
        collection.findOne {_id:id}, (err, obj) ->
          obj.adresses = [
            unite: '307'
            rue: '353 rue Saint-Nicolas'
            ville: 'Montréal'
            province: 'Québec'
            codePostal: 'H1Y 2P1'
          ]
          res.json obj

  app.namespace '/queries', ->

    # Returns the list of saved queries
    app.get ':name', (req, res) ->
      res.json [
          _id: 1
          label: 'Nouveau dossiers'
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
        

