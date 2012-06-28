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

moment = require '../assets/js/vendor/moment'
fr = require '../assets/js/vendor/moment-fr'

module.exports = (app, db) ->

  moment.lang 'fr', fr
  app.helpers
    fromNow: (date) ->
      moment(date).fromNow()
    opacityFor: (message) ->
      if message.isRead is 'true' then '.5' else '1'

  app.get '/', (req, res) ->
    res.render 'index'
      savedQueries: [
          _id: 1
          label: 'Nouveaux dossiers'
        ,
          _id: 2
          label: 'Cotisation non-payée'
        ,
          _id: 3
          label: 'Non-assuré'
      ]

  app.get '/messages', (req, res) ->
    db.collection 'messages', (err, collection) ->
      messages = []
      stream = collection.find({}, {sort:[['dateSent','desc']]}).streamRecords()
      stream.on 'data', (data) -> messages.push data
      stream.on 'end', -> res.render 'messages', {messages}
