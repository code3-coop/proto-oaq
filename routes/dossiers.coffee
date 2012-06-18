db = require('./connection').db

module.exports.getDossier = (numero) ->
  dossier = {}
  dossier._id = parseInt numero, 10
  dossier._version = 1
  dossier.nomFamille = "Deschamps (#{numero})"
  dossier.nomFamilleNaissance = ''
  dossier.prenom = 'Pierre'
  dossier.secondPrenom = ''
  dossier.prefixe =  'M.'
  dossier.suffixe = ''
  dossier.dateNaissance = '1980-07-14' # ISO 8601
  dossier.sexe = 1 # ISO 5218
  dossier.notes = [
      dateCreation: '2012-06-15T08:00:00' # ISO 8601
      priorite: 1
      contenu: 'Architecti est scientia pluribus disciplinis et variis eruditionibus ornata, cuius iudicio probantur omnia quae ab ceteris artibus perficiuntur opera. Ea nascitur ex fabrica et ratiocinatione. Fabrica est continuata ac trita usus meditatio.'
      auteur: 'Vitruve'
  ]
  dossier.adresses = [
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
  dossier
