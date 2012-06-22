module.exports = (db) ->

    savedQueries = [
        _id: 1
        label: 'Nouveaux dossiers'
      ,
        _id: 2
        label: 'Cotisation non-payée'
      ,
        _id: 3
        label: 'Non-assuré'
    ]

    getQueries: (response) ->
      response.json savedQueries

    getQuery: (id, response) ->
      for each in savedQueries when id is each._id
        response.json each
      response.send 404
    
    getResults:(id, response) ->
      resultats = []
      switch id
        when '1'
          db.collection "intervenants", {safe:true}, (err, collection) ->
            if err then throw err
            stream = collection.find().limit(2).streamRecords()
            stream.on "data", (resultat) ->
              resultats.push parseUser(resultat)
            stream.on "end", ->
              response.json resultats
        when '2'
          db.collection "intervenants", {safe:true}, (err, collection) ->
            if err then throw err
            stream = collection.find().skip(2).limit(8).streamRecords()
            stream.on "data", (resultat) ->
              resultats.push parseUser(resultat)
            stream.on "end", ->
              response.json resultats
        when '3'
          db.collection "intervenants", {safe:true}, (err, collection) ->
            if err then throw err
            stream = collection.find().skip(10).limit(3).streamRecords()
            stream.on "data", (resultat) ->
              resultats.push parseUser(resultat)
            stream.on "end", ->
              response.json resultats
        else
          response.send 404

parseUser = (resultat) ->
  {
    _id: resultat._id
    label: "#{resultat.prefixe} #{resultat.prenom} #{resultat.nomFamille}"
  }

