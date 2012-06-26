{ prologue } = require './lmlib'

prologue "Création et insertion dans la base de données de 8 messages"

{ genererMessage } = require "./generateur-messages"

{ Server, Db } = require "mongodb"


genererLot = ( nombre ) ->
    genererMessage() for i in [ 1..nombre ]


server = new Server "localhost", 27017, {auto_reconnect:true}
db = new Db "oaqdemo", server


db.open (err, db) ->
    if err then throw err
    # Insertion de plusieurs intervenants en lot
    db.collection "messages", {safe:true}, (err, collection) ->
        if err then throw err
        lot = genererLot 8
        collection.insert lot, {safe:true}, (err, result) ->
            if err then throw err
            db.close()
