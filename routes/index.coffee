moment = require '../assets/js/vendor/moment'
fr = require '../assets/js/vendor/moment-fr'

module.exports = (app, db) ->
  moment.lang 'fr', fr

  app.get '/', (req, res) ->
    db.collection 'messages', (err, collection) ->
      collection.find(isRead:'false').count (err, count) ->
        res.render 'index'
          unreadCount: count
          savedQueries: [
              _id: 1
              label: 'Nouveaux dossiers'
            ,
              _id: 2
              label: 'Cotisation non-payée'
            ,
              _id: 3
              label: 'Non-assuré'
          ]

  app.helpers
    fromNow: (date) ->
      moment(date).fromNow()
    opacityFor: (message) ->
      if message.isRead is 'true' then '.5' else '1'

  app.get '/messages', (req, res) ->
    db.collection 'messages', (err, collection) ->
      messages = []
      unreadCount = 0
      stream = collection.find().streamRecords()
      stream.on 'data', (data) ->
        messages.push data
        unreadCount += 1 if data.isRead is 'false'
      stream.on 'end', -> res.render 'messages', {messages, unreadCount}
