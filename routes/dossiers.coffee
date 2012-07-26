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

_ = require '../assets/js/vendor/underscore'
https = require 'https'
xml2js = require 'xml2js'

getDocumentLinks = (sio) ->
  options =
    host: "demo.rlnx.com"
    path: "/nuxeooaq/atom/cmis/default/children?id=46121eff-ee1b-4cf9-a6a9-04890706bafc"
    auth: process.env['NUXEO_RLNX_CREDS']
    headers: { 'User-Agent': '' }
  req = https.request options, (res) ->
    chunks = []
    res.setEncoding 'utf8'
    res.on 'data', (chunk) -> chunks.push chunk
    res.on 'end', ->
      parser = new xml2js.Parser()
      parser.parseString chunks.join(''), (err, result) ->
        sio.sockets.emit 'cmis', result['atom:entry']
  req.end()

module.exports = (app, db) ->
  getDossier: (id, response) ->
    critere =
      "_id" : "#{id}"

    contenu =
      "_keywords": 0
      
    db.collection "intervenants", {safe:true}, (err, collection) ->
      dossier = {}
      if err then throw err
      stream = collection.find(critere,contenu).streamRecords()
      stream.on "data", (resultat) ->
        dossier = resultat
      stream.on "end", ->
        if _.isEmpty(dossier)
          response.send 404
        else
          response.json dossier
          getDocumentLinks app.settings.sio

