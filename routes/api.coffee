module.exports = (app) ->

  app.namespace '/dossiers', ->

    app.get ':id', (req, res) ->
      res.json
        _id: parseInt req.params.id, 10
        _version: 1
        nomFamille: 'Deschamps'
        nomFamilleNaissance: ''
        prenom: 'Pierre'
        secondPrenom: ''
        prefixe: 'M.'
        suffixe: ''
        dateNaissance: '1980-07-14' # ISO 8601
        sexe: 1 # ISO 5218
        adresses: [
            typeAdresse: 'Affaires'
            mentionComplementaire: ''
            rue: '353 rue Saint-Nicolas'
            unite: '307'
            casePostale: ''
            ville: 'Montréal'
            province: 'Québec'
            codePostal: 'H1Y 2P1'
            pays: 'Canada'
            courriel: 'francois.x.guillemette@code3.com'
            numeroTelephone: '514-775-7061'
          ,
            typeAdresse: 'Personnelle'
            mentionComplementaire: ''
            rue: '123 rue Saint-Paul'
            unite: ''
            casePostale: ''
            ville: 'Montréal'
            province: 'Québec'
            codePostal: 'H1Y 2P1'
            pays: 'Canada'
            courriel: 'francois.x.guillemette@code3.com'
            numeroTelephone: '514-775-7061'
        ]


