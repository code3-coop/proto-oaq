_ = require '../assets/js/vendor/underscore'
module.exports = (db, BSON) ->

  deleteMessage: (id, response) ->
    db.collection "messages", {safe:true}, (err, collection) ->
      if err then throw err
      collection.remove {"_id" : new BSON.ObjectID(id)}, {safe:true}, (err, result) ->
        if err then throw err
    response.send 200

  postMessage: (request, response) ->
    message = {}
    message.subject = request.param('subject')
    message.author = request.param('author')
    message.dateSent = new Date().getTime()
    message.body = request.param('body')
    message.destination = request.param('destination')
    #message._keywords = parseKeywords message
    message.isRead = "false"
    db.collection "messages", {safe:true}, (err, collection) ->
      if err then throw err
      collection.insert message, {safe:true}, (err, result) ->
        if err then throw err
    response.send 200

  getMessages: (response) ->
    db.collection "messages", {safe:true}, (err, collection) ->
      resultats = []
      if err then throw err
      stream = collection.find().streamRecords()
      stream.on "data", (resultat) ->
        resultats.push parseMessage(resultat)
      stream.on "end", ->
        response.json resultats

  putMessage: (id, request, response) ->
    # changes = JSON.parse request.param('changes')
    changes = request.body
    db.collection "messages", {safe:true}, (err, collection) ->
      collection.update {"_id" : new BSON.ObjectID(id)}, {"$set" : changes}, {safe:true}, (err, result) ->
        if err then throw err
    response.send 200

  getMessage: (id, response) ->
    resultats = []

    if id is "nonlu"
      db.collection "messages", {safe:true}, (err, collection) ->
        resultats = []
        if err then throw err
        stream = collection.find({"isRead":"false"}).streamRecords()
        stream.on "data", (resultat) ->
          resultats.push parseMessage(resultat)
        stream.on "end", ->
          response.json resultats
    else
      critere =
        "_id" : new BSON.ObjectID(id)

      contenu =
        "_keywords": 0

      db.collection "messages", {safe:true}, (err, collection) ->
        if err then throw err
        stream = collection.find(critere, contenu).streamRecords()
        stream.on "data", (resultat) ->
          resultats.push resultat
        stream.on "end", ->
          if _.isEmpty(resultats)
            response.send 404
          else
            response.json resultats

parseMessage = (resultat)->
  {
    _id: resultat._id
    subject: resultat.subject
    isRead: resultat.isRead
  }
