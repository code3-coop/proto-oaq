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

module.exports = (db) ->

    savedQueries = [
        _id: 1
        label: 'Nouveaux dossiers'
      ,
        _id: 2
        label: 'Cotisation non-payée'
      ,
        _id: 3
        label: 'Non-assuré'
    ]

    getQueries:(response) ->
      response.json savedQueries

    getQuery:(id, response) ->
      for each in savedQueries when id is each._id
        response.json each
      response.send 404

    getResults:(id, request, response) ->
      resultats = []
      switch id
        when 'libre'
          getTextQueryResults(db, request.param('q'), response)
        when '1'
          db.collection "intervenants", {safe:true}, (err, collection) ->
            if err then throw err
            stream = collection.find().limit(2).streamRecords()
            stream.on "data", (resultat) ->
              resultats.push parseUser(resultat)
            stream.on "end", ->
              response.json resultats
        when '2'
          db.collection "intervenants", {safe:true}, (err, collection) ->
            if err then throw err
            stream = collection.find().skip(2).limit(8).streamRecords()
            stream.on "data", (resultat) ->
              resultats.push parseUser(resultat)
            stream.on "end", ->
              response.json resultats
        when '3'
          db.collection "intervenants", {safe:true}, (err, collection) ->
            if err then throw err
            stream = collection.find().skip(10).limit(3).streamRecords()
            stream.on "data", (resultat) ->
              resultats.push parseUser(resultat)
            stream.on "end", ->
              response.json resultats
        else
          response.send 404

extractKeywords = (keywords) ->
  #fix up method later to clean up params
  keywords.split /\s+/

getTextQueryResults = (db, keywords, response) ->
  if !keywords then keywords = ""
  critere = {
    "_keywords" : {
      "$all": extractKeywords keywords
    }
  }

  contenu =
    "_keywords": 0
  
  #using streaming still for this part, might want to return partial results sometime
  db.collection "intervenants", {safe:true}, (err, collection) ->
    resultats = []
    if err then throw err
    stream = collection.find(critere,contenu).streamRecords()
    stream.on "data", (resultat) ->
      resultats.push parseUser(resultat)
    stream.on "end", ->
      response.json resultats
    
parseUser = (resultat) ->
  {
    _id: resultat._id
    label: "#{resultat.prefixe} #{resultat.prenom} #{resultat.nomFamille}"
  }

