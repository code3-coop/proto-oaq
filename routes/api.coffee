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
        notes: [
            dateCreation: '2012-06-15T08:00:00' # ISO 8601
            priorite: 1
            contenu: 'Architecti est scientia pluribus disciplinis et variis eruditionibus ornata, cuius iudicio probantur omnia quae ab ceteris artibus perficiuntur opera. Ea nascitur ex fabrica et ratiocinatione. Fabrica est continuata ac trita usus meditatio.'
            auteur: 'Vitruve'
        ]
        adresses: [
            type: 'Affaires'
            mentionComplementaire: ''
            rue: '353 rue Saint-Nicolas'
            unite: '307'
            casePostale: ''
            ville: 'Montréal'
            province: 'Québec'
            codePostal: 'H1Y 2P1'
            pays: 'Canada'
            courriel: 'francois.x.guillemette@code3.ca'
            numeroTelephone: '514-775-7061'
          ,
            type: 'Personnelle'
            mentionComplementaire: ''
            rue: '123 rue Saint-Paul'
            unite: ''
            casePostale: ''
            ville: 'Montréal'
            province: 'Québec'
            codePostal: 'H1Y 2P1'
            pays: 'Canada'
            courriel: 'francois.x.guillemette@gmail.com'
            numeroTelephone: '514-775-7061'
        ]


