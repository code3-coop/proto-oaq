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
    predefinedQueries: new OAQ.Queries(name:'predef')
    currentQuery: new OAQ.Query()
    currentDossier: new OAQ.Dossier()

  load: ->
    (@get 'predefinedQueries').fetch
      success: @initCurrentQuery

  initCurrentQuery: =>
    @set 'currentQuery', (@get 'predefinedQueries').first()
    (@get 'currentQuery').refresh success: @initCurrentDossier
    each.refresh() for each in (@get 'predefinedQueries').rest()

  initCurrentDossier: =>
    (@get 'currentQuery').curr().fetch
      success: @setCurrentDossier

  moveToNextDossier: ->
    (@get 'currentQuery').next().fetch
      success: @setCurrentDossier

  moveToPrevDossier: ->
    (@get 'currentQuery').prev().fetch
      success: @setCurrentDossier

  setCurrentDossier: (dossier) =>
    @set 'currentDossier', dossier
