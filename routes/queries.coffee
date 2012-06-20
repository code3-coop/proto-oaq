exports.getQueries = (name, response, db)->
  response.json [
      _id: 1
      label: 'Nouveaux dossiers'
    ,
      _id: 2
      label: 'Cotisation non-payée'
    ,
      _id: 3
      label: 'Non-assuré'
  ]

parseUser = (resultat)->
  {
    _id: resultat._id
    label: "#{resultat.prefixe} #{resultat.prenom} #{resultat.nomFamille}"
  }

exports.getResults = (id, response, db)->
  resultats = []
  if id == '1'
    db.collection "intervenants", {safe:true}, (err, collection) ->
      if err then throw err
      stream = collection.find().limit(2).streamRecords()
      stream.on "data", (resultat) ->
        resultats.push parseUser(resultat)
      stream.on "end", ->
        response.json resultats
  if id == '2'
    db.collection "intervenants", {safe:true}, (err, collection) ->
      if err then throw err
      stream = collection.find().skip(2).limit(8).streamRecords()
      stream.on "data", (resultat) ->
        resultats.push parseUser(resultat)
      stream.on "end", ->
        response.json resultats
  if id == '3'
    db.collection "intervenants", {safe:true}, (err, collection) ->
      if err then throw err
      stream = collection.find().skip(10).limit(3).streamRecords()
      stream.on "data", (resultat) ->
        resultats.push parseUser(resultat)
      stream.on "end", ->
        response.json resultats
