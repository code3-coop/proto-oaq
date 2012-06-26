moment = require '../assets/js/vendor/moment'
fr = require '../assets/js/vendor/moment-fr'

module.exports = (app, db) ->
  moment.lang 'fr', fr

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

  app.helpers
    fromNow: (date) ->
      moment(date).fromNow()

  app.get '/messages', (req, res) ->
    db.collection 'messages', (err, collection) ->
      collection.find().toArray (err, results) ->
        res.render 'messages'
          messages: results
