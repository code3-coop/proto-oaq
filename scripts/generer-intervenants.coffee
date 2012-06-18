{ prologue } = require './lmlib'

prologue "Générer des intervenants"

{ genererIntervenant } = require "./generateur-intervenant"

nombre = 10

console.log JSON.stringify genererIntervenant(), null, "  " for i in [ 1..nombre ]
