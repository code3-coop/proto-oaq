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

#= require ../vendor/jquery
#= require ../vendor/backbone
#= require ../vendor/handlebars

#= require ../models/Dossier

@OAQ = window.OAQ ? {}

class @OAQ.QueryView extends Backbone.View
  initialize: ->
    @template = Handlebars.compile ($ '#queries-template').html()
    @model.on 'change:currentQuery change:currentDossier', @render
    @render()

  events:
    'click a[href^=/dossiers/]': 'onDossierClick'
    'click :button:contains("consulter")': 'onConsulterClick'
    'click :button:contains("actualiser")': 'onActualiserClick'

  render: =>
    context = {queries:[]}
    currentQuery = @model.get('currentQuery')
    currentDossier = @model.get('currentDossier')

    @model.get('savedQueries').each (eachQuery) ->
      queryView = {info: eachQuery.toJSON(), results:[]}
      queryView.isCurrentQuery = if currentQuery then (currentQuery.id is eachQuery.id) else no
      if queryView.isCurrentQuery
        currentQuery.get('results').each (eachResult) ->
          resultView = {info: eachResult.toJSON()}
          resultView.isCurrentDossier = if currentDossier then currentDossier.id is eachResult.id else no
          queryView.results.push(resultView)
      context.queries.push(queryView)

    ($ @el).html @template context

  onDossierClick: (e) =>
    e.preventDefault()
    id = ($ e.target).data 'dossierid'
    queryId = @model.get('currentQuery').id
    OAQ.router.navigate("recherches/#{queryId}/dossiers/#{id}", {trigger:yes})

  onConsulterClick: (e) =>
    id = ($ e.target).data 'queryid'
    OAQ.router.navigate("recherches/#{id}", {trigger:yes})

  onActualiserClick: (e) =>
    (@model.get 'currentQuery').execute
      success: @render
