{ prologue } = require './lmlib'

prologue "Création et insertion dans la base de données de 5000 intervenants"

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
        lot = genererLot 5000
        collection.insert lot, {safe:true}, (err, result) ->
            if err then throw err
            db.close()
