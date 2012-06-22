module.exports = (db) ->

  savedMessages = [
      _id: 1
      subject: 'Un message'
      isRead: false
    ,
      _id: 2
      subject: 'Un autre'
      isRead: true
    ,
      _id: 3
      subject: 'Plein de messages'
      isRead: false
  ]

  deleteMessage: (id, response) ->
    response.send 501

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
    response.json savedMessages

  getMessage: (id, response) ->
    resultat = []
    if id is "nonlu"
      for each in savedMessages when !each.isRead
        resultat.push each
      response.json resultat
    else
      id = parseInt(id,10)
      for each in savedMessages when id is each._id
        response.json each
      response.send 404
