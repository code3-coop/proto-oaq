module.exports = (app) ->
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
