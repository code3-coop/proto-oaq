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

{ prologue } = require './lmlib'

prologue "Création et insertion dans la base de données de 8 messages"

{ genererMessage } = require "./generateur-messages"

{ Server, Db } = require "mongodb"

server = new Server "localhost", 27017, {auto_reconnect:true}
db = new Db "oaqdemo", server

genererLot = ( nombre, numeros ) ->
  genererMessage(numeros[i - 1].numero) for i in [ 1..nombre ]

db.open (err, db) ->
  if err then throw err
  (db.collection 'intervenants').find({}, {numero:1}, {limit:8}).toArray (err, numeros) ->
    # Insertion de plusieurs intervenants en lot
    db.collection "messages", {safe:true}, (err, collection) ->
      if err then throw err
      lot = genererLot 8, numeros
      collection.insert lot, {safe:true}, (err, result) ->
        if err then throw err
        db.close()
