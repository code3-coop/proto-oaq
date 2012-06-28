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

{ prologue } = require './lmlib'

prologue "Création et insertion dans la base de données de 500 intervenants"

{ genererIntervenant } = require "./generateur-intervenant"

{ Server, Db } = require "mongodb"


genererLot = ( nombre ) ->
    genererIntervenant() for i in [ 1..nombre ]


server = new Server "localhost", 27017, {auto_reconnect:true}
db = new Db "oaqdemo", server


db.open (err, db) ->
    if err then throw err
    # Insertion de plusieurs intervenants en lot
    db.collection "intervenants", {safe:true}, (err, collection) ->
        if err then throw err
        lot = genererLot 500
        collection.insert lot, {safe:true}, (err, result) ->
            if err then throw err
            db.close()
