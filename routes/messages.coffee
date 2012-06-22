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
    response.send 501

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
      console.log "in else with id #{id}"
      for each in savedMessages when id is each._id
        console.log "match found"
        response.json each
      response.send 404
