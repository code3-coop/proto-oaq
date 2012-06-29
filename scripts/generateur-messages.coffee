# Copyright (C) 2012  CODE3 Cooperative de solidarite
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
    "Utilisateur en défaut de paiement: #"
    "As-tu regardé ce dossier? #"
    "Problème dossier #"
    "Formation incomplète pour dossier #"
    "Paiement de souscription non reçu pour dossier #"
]

loremIpsum = fs.readFileSync( "./lorem-ipsum.txt", "utf8" ).split "\n\n"
pattern = /[\w\u00C0-\u00FF]+/g

exports.genererMessage = (numeroDossier) ->
    message = {}
    message.destination = genererNumero()
    message.isRead = "false"
    message.author = "#{auHasardDans prenoms} #{auHasardDans noms}"
    message.subject = "#{auHasardDans subjects}#{numeroDossier}"
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

