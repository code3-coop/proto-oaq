# Copyright (C) 2012  Louis Martin
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

{ formatDate, addDays, numberOfDays } = require './lmlib'

fs = require 'fs'

dateDebut = new Date 1950, 0, 1
dateFin = new Date 2012, 0, 1
nombreJoursEcoules = numberOfDays dateDebut, dateFin

prenoms = [
    "Albert"
    "Béatrice"
    "Charles"
    "Diane"
    "Éric"
    "Fanny"
    "Georges"
    "Henriette"
    "Isidor"
    "Jeannette"
    "Karl"
    "Louise"
    "Maurice"
    "Nicole"
    "Oscar"
    "Patricia"
    "Quentin"
    "Rita"
    "Serge"
    "Thérèse"
    "Ulric"
    "Vivianne"
    "Wilfrid"
    "Xéna"
    "Yvon"
    "Zoé"
]

noms = [
    "Asselin"
    "Bernardin"
    "Champagne"
    "Deneault"
    "Elliot"
    "Falardeau"
    "Gagnon"
    "Harris"
    "Imbeault"
    "Jalbert"
    "Kennedy"
    "Loiselle"
    "Martin"
    "Nadeau"
    "O'Reilly"
    "Paquin"
    "Quenneville"
    "Richmond"
    "Savoie"
    "Therrien"
    "Underwood"
    "Villeneuve"
    "White"
    "Xolan"
    "Young"
    "Zeron"
]

prefixes = [
	"Docteur"
	"Honorable"
	"Maître"
	"Professeur"
	"Révérend"
]

suffixes = [
	"MBA"
	"Ph. D."
	"c.r."
	"LL. B."
	"avocat"
	"architecte"
]

sexes = [
	"0"
	"1"
	"2"
	"9"
]

rues = [
    "rue Notre-Dame"
    "boulevard Saint-Jean"
    "rue Prince-Arthur"
    "rue Ontario"
    "avenue Victoria"
    "avenue des Pins"
    "rue Chabot"
    "boulevard Métropolitain"
    "12ième avenue"
    "boulevard Lasalle"
]

villes = [
    "Saint-Jean"
    "Montréal"
    "Rimouski"
    "Québec"
    "Mont-Tremblant"
    "Sherbrooke"
    "Rigaud"
    "Thetford Mines"
    "Asbestos"
    "Bourcherville"
]

urls = [
    "http://site.un.org/"
    "http://site.deux.org/"
    "http://site.trois.org/"
    "http://site.quatre.org/"
    "http://site.cinq.org/"
    "http://site.six.org/"
    "http://site.sept.org/"
    "http://site.huit.org/"
    "http://site.neuf.org/"
    "http://site.dix.org/"
]

provinces = [
    "Nouveau Brunswick"
    "Ontario"
    "Québec"
]

loremIpsum = fs.readFileSync( "./lorem-ipsum.txt", "utf8" ).split "\n\n"
pattern = /[\w\u00C0-\u00FF]+/g

exports.genererIntervenant = ->
    intervenant = {}
    intervenant.numero = genererNumero()
    intervenant._id = intervenant.numero
    intervenant.nomFamille = auHasardDans noms
    intervenant.prenom = auHasardDans prenoms
    intervenant.secondPrenom = if auHasard() then auHasardDans prenoms else ""
    intervenant.prefixe = if auHasard() then auHasardDans prefixes else ""
    intervenant.suffixe = if auHasard() then auHasardDans suffixes else ""
    intervenant.nomFamilleNaissance = if auHasard() then auHasardDans noms else ""
    intervenant.sexe = auHasardDans sexes
    intervenant.dateNaissance = genererDate()
    intervenant.adresses = genererAdresses()
    intervenant.notes = if auHasard() then genererSerie 1, 3, genererNotes
    intervenant._keywords = genererKeywords intervenant
    intervenant


genererNotes = ->
    dateCreation: "2012-06-#{auHasardDans [10..30]}T08:00:00"
    priorite: auHasardDans [1..5]
    contenu: auHasardDans loremIpsum
    auteur: "Administrateur"

genererKeywords = (intervenant) ->
    keywords = []
    keywords = keywords.concat intervenant.numero.toLowerCase().match(pattern)

    keywords = keywords.concat( [].concat.apply([], extractKeywords adresse for adresse in intervenant.adresses))
    if intervenant.notes? then (keywords = keywords.concat( [].concat.apply([], note.contenu.toLowerCase().match(pattern) for note in intervenant.notes)))
    keywords = keywords.concat intervenant.nomFamille.toLowerCase().match(pattern)
    keywords = keywords.concat intervenant.prenom.toLowerCase().match(pattern)
    keywords = keywords.concat intervenant.nomFamilleNaissance.toLowerCase().match(pattern)

extractKeywords = (adresse) ->
    keywords = []
    keywords = keywords.concat adresse.ville.toLowerCase().match(pattern)
    keywords = keywords.concat adresse.pays.toLowerCase().match(pattern)
    keywords = keywords.concat adresse.province.toLowerCase().match(pattern)
    keywords = keywords.concat adresse.courriel.toLowerCase().match(pattern)
    keywords = keywords.concat adresse.codePostal.toLowerCase().match(pattern)
    keywords = keywords.concat adresse.numeroTelephone

genererNumero = ->
    genererChaineNumerique 9

genererAdresses = ->
  adresses = [
    {
      type: "Affaires"
      mentionComplementaire: "Une mention complémentaire"
      rue: "#{ genererChaineNumerique 4 } #{ auHasardDans rues }"
      unite: if auHasard() then genererChaineNumerique 3 else ""
      casePostale: ""
      ville: auHasardDans villes
      province: auHasardDans provinces
      codePostal: ""
      pays: "Canada"
      courriel : "#{ genererChaineNumerique 6 }@#{ auHasardDans( urls )[7..-2] }"
      numeroTelephone : genererNumeroTelephone()
    },
    {
      type: "Personnelle"
      mentionComplementaire: "Une mention complémentaire"
      rue: "#{ genererChaineNumerique 4 } #{ auHasardDans rues }"
      unite: if auHasard() then genererChaineNumerique 3 else ""
      casePostale: ""
      ville: auHasardDans villes
      province: auHasardDans provinces
      codePostal: ""
      pays: "Canada"
      courriel : "#{ genererChaineNumerique 6 }@#{ auHasardDans( urls )[7..-2] }"
      numeroTelephone : genererNumeroTelephone()
    }
  ]
  adresses

genererSerie = ( min, max, fonction ) ->
    nombreOccurence = randomInt( max - min + 1 ) + min
    fonction() for i in [ 0...nombreOccurence ]

genererListe = ( min, max, liste ) ->
    nombreOccurence = randomInt( max - min + 1 ) + min
    auHasardDans liste for i in [ 0...nombreOccurence ]

auHasard = ->
	Math.random() < 0.5

auHasardDans = ( liste ) ->
    liste[ randomInt liste.length ]

genererChaineNumerique = ( length ) -> 
    ( randomInt 10 for i in [ 1..length ] ).join ""

genererDate = ->
    formatDate addDays dateDebut, randomInt nombreJoursEcoules 

genererNumeroTelephone = ->
    "(#{ genererChaineNumerique 3 }) #{ genererChaineNumerique 3 }-#{ genererChaineNumerique 4 }" 

randomInt = ( entier ) ->
    Math.floor Math.random() * entier

