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

    getQueries:(response) ->
      response.json savedQueries

    getQuery:(id, response) ->
      for each in savedQueries when id is each._id
        response.json each
      response.send 404

    getResults:(id, request, response) ->
      resultats = []
      switch id
        when 'libre'
          getTextQueryResults(db, request.param('q'), response)
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

extractKeywords = (keywords) ->
  #fix up method later to clean up params
  keywords.split " "

getTextQueryResults = (db, keywords, response) ->
  if !keywords then keywords = ""
  critere = {
    "_keywords" : {
      "$all": extractKeywords keywords
    }
  }

  contenu =
    "_keywords": 0
  
  #using streaming still for this part, might want to return partial results sometime
  db.collection "intervenants", {safe:true}, (err, collection) ->
    resultats = []
    if err then throw err
    stream = collection.find(critere,contenu).streamRecords()
    stream.on "data", (resultat) ->
      resultats.push parseUser(resultat)
    stream.on "end", ->
      response.json resultats
    
parseUser = (resultat) ->
  {
    _id: resultat._id
    label: "#{resultat.prefixe} #{resultat.prenom} #{resultat.nomFamille}"
  }

