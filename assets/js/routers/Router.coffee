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

#= require ../vendor/backbone
#= require ../models/Dossier

@OAQ = window.OAQ ? {}

class @OAQ.Router extends Backbone.Router
  routes:
    'dossiers/:id' : 'findDossier'
    'recherches/:id' : 'findQuery'
    'recherches/:queryId/dossiers/:dossierId' : 'findDossierInQuery'

  initialize: (@application) ->

  findDossier: (id) ->
    # Finds a dossier by it's id. Sets the currentQuery to null and the current
    # Dossier to the one found (if any).
    new OAQ.Dossier(_id:id).fetch
      success: (found) =>
        # @application.set 'currentQuery', null
        @application.set 'currentDossier', found
      error: =>
        @navigate('/', {trigger:yes})

  findQuery: (id) ->
    # Finds a query by it's id. Sets the currentQuery to the one found (if any)
    # and the currentDossier the the first match (if any).
    new OAQ.Query(_id:id).fetch
      success: (found) =>
        found.execute
          success: (results) =>
            results.first().fetch
              success: (firstResult) =>
                @application.set 'currentQuery', found
                @application.set 'currentDossier', firstResult
                @navigate("recherches/#{id}/dossiers/#{firstResult.id}", {trigger:no})
              error: =>
                @navigate('/', {trigger:yes})
      error: =>
        @navigate('/', {trigger:yes})

  findDossierInQuery: (queryId, dossierId) ->
    # Finds the Dossier by it's id and sets it as the currentDossier. Then, it
    # finds the query by it's id. If the Dossier is still in the query, it then
    # sets the found query as the currentQuery; if not, the router navigates
    # silently to `/dossier/:dossierId` 
    new OAQ.Dossier(_id:dossierId).fetch
      success: (foundDossier) =>
        @application.set 'currentDossier', foundDossier
        if parseInt(queryId,10) isnt @application.get('currentQuery')?.id
          new OAQ.Query(_id:queryId).fetch
            success: (foundQuery) =>
              foundQuery.execute
                success: (results) =>
                  if results.find((t) -> t.id is foundDossier.id)
                    @application.set 'currentQuery', foundQuery
                  else
                    @navigate("dossiers/#{dossierId}", {replace:yes, trigger:yes})
            error: =>
              # Well, at least the dossier id is valid...
              @navigate("dossiers/#{dossierId}", {replace:yes, trigger:no})
      error: =>
        # Is the query id even valid ?
        @navigate("recherches/#{queryId}", {replace:yes, trigger:yes})
