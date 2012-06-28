moment = require '../assets/js/vendor/moment'
fr = require '../assets/js/vendor/moment-fr'

module.exports = (app, db) ->

  moment.lang 'fr', fr
  app.helpers
    fromNow: (date) ->
      moment(date).fromNow()
    opacityFor: (message) ->
      if message.isRead is 'true' then '.5' else '1'

  app.get '/', (req, res) ->
    res.render 'index'
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

  app.get '/messages', (req, res) ->
    db.collection 'messages', (err, collection) ->
      messages = []
      stream = collection.find({}, {sort:[['dateSent','desc']]}).streamRecords()
      stream.on 'data', (data) -> messages.push data
      stream.on 'end', -> res.render 'messages', {messages}
