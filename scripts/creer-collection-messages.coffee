{ prologue } = require './lmlib'

prologue "Création de la collection 'messages'"

{ Server, Db } = require "mongodb"

server = new Server "localhost", 27017, {auto_reconnect:true}
db = new Db "oaqdemo", server

db.open (err, db) ->
    if err then throw err
    # Création d'une collection seulement si elle n'existe pas déjà
    db.createCollection "messages", {safe:true}, (err, collection) ->
        if err then throw err
        db.close()
