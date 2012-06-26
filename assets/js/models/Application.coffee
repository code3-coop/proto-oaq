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

#= require Dossier
#= require Query
#= require ../collections/Queries
#= require ../vendor/backbone

@OAQ = window.OAQ ? {}

class @OAQ.Application extends Backbone.Model
  defaults:
    savedQueries: new OAQ.Queries(OAQ._savedQueries)
    adhocQueries: new OAQ.Queries()

  getQuery: (id) ->
    @get('savedQueries').get(id) or @get('adhocQueries').get(id)

  moveToNextDossier: -> @_moveTo 'next'
  moveToPrevDossier: -> @_moveTo 'prev'

  _moveTo: (direction) ->
    (@get 'currentQuery')[direction] (@get 'currentDossier').id, (id) ->
      OAQ.router.navigate "dossiers/#{id}", {trigger:yes}

