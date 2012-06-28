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

#= require vendor/jquery
#= require vendor/bootstrap

#= require models/Application
#= require models/Query
#= require routers/Router

#= require views/QueryView
#= require views/ProfileView
#= require views/ContextView

#= require navbar

@OAQ = window.OAQ ? {}

$ ->
  application = OAQ.app = new OAQ.Application()

  new OAQ.QueryView
    model: application
    propertyName: 'savedQueries'
    el: ($ '#x-saved-query-tree')

  new OAQ.QueryView
    model: application
    propertyName: 'adhocQueries'
    el: ($ '#x-adhoc-query-tree')

  new OAQ.ProfileView
    model: application
    el: ($ '#x-profile-info')

  new OAQ.ContextView
    model: application
    el: ($ '#x-current-context')

  ($ '.form-search').on 'submit', (e) ->
    criteria = ($ '.search-query').val()
    encodedCriteria = encodeURIComponent criteria
    query = new OAQ.Query
      _id: encodedCriteria
      criteria: criteria
      label: _.map(criteria.split(/\s+/), (m)->"«#{m}»").join(' ET ')
    application.get('adhocQueries').add(query)
    query.execute
      success: (results) ->
        application.set('currentQuery', query)
        OAQ.router.navigate "dossiers/#{results.first().id}", {trigger:yes}
    no # propagation

  ($ '#x-context-picker').on 'change', ->
    # should use router to save context to url instead...
    application.set 'currentContext', ($ @).val()

  ($ '#x-profile-nav-next').on 'click', ->
    application.moveToNextDossier()

  ($ '#x-profile-nav-prev').on 'click', ->
    application.moveToPrevDossier()

  OAQ.router = new OAQ.Router()
  Backbone.history.start()
