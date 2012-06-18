{ prologue } = require './lmlib'

prologue "Création de la collection 'intervenants'"

{ Server, Db } = require "mongodb"

server = new Server "localhost", 27017, {auto_reconnect:true}
db = new Db "oaqdemo", server

db.open (err, db) ->
    if err then throw err
    # Création d'une collection seulement si elle n'existe pas déjà
    db.createCollection "intervenants", {safe:true}, (err, collection) ->
        if err then throw err
        db.close()
