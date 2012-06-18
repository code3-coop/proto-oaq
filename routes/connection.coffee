{ Server, Db } = require "mongodb"
server = new Server "localhost", 27017, {auto_reconnect:true}
db = new Db "oaqdemo", server
module.exports.db
