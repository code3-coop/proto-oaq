fs = require 'fs'

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

subjects = [
    "Nouveaux utilisateurs en défaut de paiement."
    "As-tu regardé ce dossier?"
    "Problème dossier #12345"
    "Rappel : fin de période de souscription"
    "Rappel : plusieurs utilisateurs en défaut"
]

loremIpsum = fs.readFileSync( "./lorem-ipsum.txt", "utf8" ).split "\n\n"
pattern = /[\w\u00C0-\u00FF]+/g

exports.genererMessage = ->
    message = {}
    message.destination = genererNumero()
    message.isRead = "false"
    message.author = "#{auHasardDans prenoms} #{auHasardDans noms}"
    message.subject = auHasardDans subjects
    message.body = auHasardDans loremIpsum
    message._keywords = genererKeywords message
    message.dateSent = new Date().getTime() - randomInt(30*24*60)*60*1000
    message

genererKeywords = (message) ->
    keywords = []
    keywords = keywords.concat message.author.toLowerCase().match(pattern)
    keywords = keywords.concat message.subject.toLowerCase().match(pattern)
    keywords = keywords.concat message.body.toLowerCase().match(pattern)
    keywords

genererNumero = ->
    randomInt 10000


auHasard = ->
	Math.random() < 0.5

auHasardDans = ( liste ) ->
    liste[ randomInt liste.length ]

randomInt = ( entier ) ->
    Math.floor Math.random() * entier

