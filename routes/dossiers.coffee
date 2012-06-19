{ Server, Db } = require "mongodb"
server = new Server "localhost", 27017, {auto_reconnect:true}
db = new Db "oaqdemo", server

module.exports.getDossier = (numero, response) ->
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

