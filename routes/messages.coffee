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

_ = require '../assets/js/vendor/underscore'

module.exports = (app, db, BSON) ->

  deleteMessage: (id, response) ->
    db.collection "messages", {safe:true}, (err, collection) ->
      if err then throw err
      collection.remove {"_id" : new BSON.ObjectID(id)}, {safe:true}, (err, result) ->
        if err then throw err
    response.send 200

  postMessage: (request, response) ->
    message = {}
    message.subject = request.param('subject')
    message.author = request.param('author')
    message.dateSent = new Date().getTime()
    message.body = request.param('body')
    message.destination = request.param('destination')
    #message._keywords = parseKeywords message
    message.isRead = "false"
    db.collection "messages", {safe:true}, (err, collection) ->
      if err then throw err
      collection.insert message, {safe:true}, (err, result) ->
        if err then throw err
    response.send 200

  getMessages: (response) ->
    db.collection "messages", {safe:true}, (err, collection) ->
      resultats = []
      if err then throw err
      stream = collection.find().streamRecords()
      stream.on "data", (resultat) ->
        resultats.push parseMessage(resultat)
      stream.on "end", ->
        response.json resultats

  putMessage: (id, request, response) ->
    changes = request.body
    db.collection "messages", {safe:true}, (err, collection) ->
      collection.update {"_id" : new BSON.ObjectID(id)}, {"$set" : changes}, {safe:true}, (err, result) ->
        if err then throw err
        collection.find({isRead:'false'}, {sort:[['dateSent','desc']]}).toArray (err, results) ->
          app.settings.sio.sockets.emit 'change:unread', results
    response.send 200

  getMessage: (id, response) ->
    resultats = []

    if id is "nonlu"
      db.collection "messages", {safe:true}, (err, collection) ->
        resultats = []
        if err then throw err
        stream = collection.find({isRead:'false'}, {sort:[['dateSent', 'desc']]}).streamRecords()
        stream.on "data", (resultat) ->
          resultats.push parseMessage(resultat)
        stream.on "end", ->
          response.json resultats
    else
      critere =
        "_id" : new BSON.ObjectID(id)

      contenu =
        "_keywords": 0

      db.collection "messages", {safe:true}, (err, collection) ->
        if err then throw err
        stream = collection.find(critere, contenu).streamRecords()
        stream.on "data", (resultat) ->
          resultats.push resultat
        stream.on "end", ->
          if _.isEmpty(resultats)
            response.send 404
          else
            response.json resultats

parseMessage = (resultat)->
  {
    _id: resultat._id
    subject: resultat.subject
    isRead: resultat.isRead
  }
