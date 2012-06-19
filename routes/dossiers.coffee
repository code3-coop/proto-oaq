mongo = require('mongodb')

exports.getDossier = (numero, response, app) ->
  db = new mongo.Db(app.set('mongoDB'), new mongo.Server( app.set('mongoHost'), app.set('mongoPort'), {}), {native_parser:false})
  critere =
    "numero" : "#{numero}"

  contenu =
    "_keywords": 0

  db.open (err, db) ->
    db.collection "intervenants", {safe:true}, (err, collection) ->
      dossier = {}
      if err then throw err
      stream = collection.find(critere,contenu).streamRecords()
      stream.on "data", (resultat) ->
        dossier = resultat
      stream.on "end", ->
        db.close()
        response.json dossier

