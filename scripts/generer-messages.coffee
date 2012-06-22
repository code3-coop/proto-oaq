{ prologue } = require './lmlib'

prologue "Générer des messages"

{ genererMessage } = require "./generateur-messages"

nombre = 10

console.log JSON.stringify genererMessage(), null, "  " for i in [ 1..nombre ]
