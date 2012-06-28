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

mongo = require 'mongodb'

module.exports = (app, dossiers, queries, messages) ->

  app.namespace '/dossiers', ->
    app.get ':id', (req, res) ->
      dossiers.getDossier(req.params.id, res)

  app.namespace '/queries', ->
    # Returns the list of saved queries
    app.get '/', (req, res) ->
      queries.getQueries(res)
    
    # Finds a saved query by it's id
    app.get ':id', (req, res) ->
      queries.getQuery(parseInt(req.params.id,10), res)

    # Finds a saved query by it's id and executes it.
    app.get ':id/results', (req, res) ->
      queries.getResults(req.params.id, req, res)

  app.namespace '/messages', ->
    app.get '/', (req, res) ->
      messages.getMessages(res)

    app.get ':id', (req, res) ->
      messages.getMessage(req.params.id, res)

    app.delete ':id', (req, res) ->
      messages.deleteMessage(req.params.id, res)

    app.post '/', (req, res) ->
      messages.postMessage(req, res)

    app.put '/:id', (req, res) ->
      messages.putMessage(req.params.id, req, res)
