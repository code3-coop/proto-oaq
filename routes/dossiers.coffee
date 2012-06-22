_ = require '../assets/js/vendor/underscore'

module.exports = (db) ->
  getDossier: (id, response) ->
    critere =
      "_id" : "#{id}"

    contenu =
      "_keywords": 0
      
    db.collection "intervenants", {safe:true}, (err, collection) ->
      dossier = {}
      if err then throw err
      stream = collection.find(critere,contenu).streamRecords()
      stream.on "data", (resultat) ->
        dossier = resultat
      stream.on "end", ->
        if _.isEmpty(dossier)
          response.send 404
        else
          response.json dossier
