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

# JavaScript Library from Louis Martin

#
# Prologue
#

exports.prologue = ( titre ) ->
    console.time "Exécution"
    console.log "#{titre} : début de l'exécution à #{exports.formatTime( new Date() )} du #{exports.formatDate( new Date() )}\n"
    process.on "exit", -> 
        console.log "\n#{titre} : fin de l'exécution"
        console.timeEnd "Exécution"
        


#
# Sort in French Canadian sequence 
#

tableEquivalence = {
    "À": "A"
    "Â": "A"
    "Ä": "A"
    "Ç": "C"
    "É": "E"
    "È": "E"
    "Ê": "E"
    "Ë": "E"
    "Î": "I"
    "Ï": "I"
    "Ô": "O"
    "Ö": "O"
    "Ù": "U"
    "Û": "U"
    "Ü": "U"
}

exports.sortFrenchCanadian = ( a, b ) ->
    if a is b then return 0
    lengthA = a.length
    lengthB = b.length
    if lengthA is 0 then return -1
    if lengthB is 0 then return 1
    for i in [ 0...Math.min( lengthA, lengthB ) ]
        charA = a[ i ]
        charB = b[ i ]
        if charA isnt charB
            upperA = charA.toUpperCase()
            upperB = charB.toUpperCase()
            normA = tableEquivalence[ upperA ] ? upperA
            normB = tableEquivalence[ upperB ] ? upperB
            if normA < normB then return -1
            if normA > normB then return 1
            if upperA < upperB then return -1
            if upperA > upperB then return 1
            if charA is upperA then return 1 else return -1
    if lengthA < lengthB then return -1 else return 1

#
# Manipulating date
#

dayInMilliseconds = 24 * 60 * 60 * 1000

exports.addDays = ( date, numberOfDays ) ->
    new Date date.getTime() + ( numberOfDays * dayInMilliseconds )


exports.numberOfDays = ( dateA, dateB ) ->
    ( dateB.getTime() - dateA.getTime() ) / dayInMilliseconds


#   
# Formatters
#

exports.formatDate = ( date, separation = "-" ) ->
    year = date.getFullYear()
    month = ( "0" + ( date.getMonth() + 1 ) )[ -2..-1 ]
    day = ( "0" + date.getDate() )[ -2..-1 ]
    "#{year}#{separation}#{month}#{separation}#{day}"


exports.formatTime = ( date, separation = ":" ) ->
    hours = ( "0" + date.getHours() )[ -2..-1 ]
    minutes = ( "0" + date.getMinutes() )[ -2..-1 ]
    seconds = ( "0" + date.getSeconds() )[ -2..-1 ]
    "#{hours}#{separation}#{minutes}#{separation}#{seconds}"


exports.formatDateTime = ( date, separationDate = "-", separationTime = ":" ) ->
    "#{exports.formatDate( date, separationDate )} #{exports.formatTime( date, separationTime )}"


exports.formatDollar = ( value, padLeft = 0, decimalSymbol = ",", groupSymbol = "\u00A0", spaceSymbol = "\u00A0", currencySymbol = "$" ) ->
    parts = Math.abs( value ).toFixed( 2 ).split "."
    units = splitUnits parts[ 0 ], groupSymbol
    cents = parts[ 1 ]
    result = if value < 0 
        "(#{units}#{decimalSymbol}#{cents}#{currencySymbol})"
    else 
        "#{units}#{decimalSymbol}#{cents}#{spaceSymbol}#{currencySymbol}"
    result = " " + result while result.length < padLeft
    result


splitUnits = ( units, groupSymbol ) ->
    postfix = ""
    while units.length > 3 
        postfix = groupSymbol + units[-3..-1] + postfix
        units = units[0..-4]
    units += postfix


#
# Testing if an object in empty
#

exports.isEmpty = ( obj ) ->
  Object.keys( obj ).length == 0

#
# Dollar
#

class exports.Dollar
    
    constructor: ( value, noScaling = false ) ->
        if noScaling then @value = Math.round( value ) else @value = Math.round( value * 100 )
        # Object.freeze( @ ) # Rend l'objet immuable mais le temps d'exécution est plus long ( X 2.5 )
    
    # object.constructor serait plus précis que instanceof
    @checkType: ( object ) ->
        if object.constructor isnt Dollar
            throw new Error "#{object} n'est pas une instance de la classe Dollar"
    
    @min: ( dollarA, dollarB ) ->
        @checkType dollarA
        @checkType dollarB
        if dollarA.value <= dollarB.value then dollarA else dollarB
    
    @max: ( dollarA, dollarB ) ->
        @checkType dollarA
        @checkType dollarB
        if dollarA.value >= dollarB.value then dollarA else dollarB
    
    add: ( dollar ) ->
        Dollar.checkType dollar
        new Dollar @value + dollar.value, true 
        
    subtract: ( dollar ) ->
        Dollar.checkType dollar
        new Dollar @value - dollar.value, true
        
    multiply: ( multiplicand ) ->
        new Dollar @value * multiplicand, true
        
    divide: ( divisor ) ->
        new Dollar @value / divisor, true
    
    format: ( padLeft = 0 )->
        exports.formatDollar @toNumber(), padLeft
    
    toString: ->
        @toNumber().toString()
    
    toNumber: ->
        @value / 100
    
    isZero: ->
        @value == 0
    
    isGreaterThan: ( dollar ) ->
        Dollar.checkType dollar
        @value > dollar.value
    
    isLessThan: ( dollar ) ->
        Dollar.checkType dollar
        @value < dollar.value
    
    isEqualTo: ( dollar ) ->
        Dollar.checkType dollar
        @value == dollar.value
    

