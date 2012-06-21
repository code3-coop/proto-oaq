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
    Handlebars.registerHelper 'eachWithIndex', (collection, options) =>
      currentIndex = @model.get('currentQuery').get('index')
      out = ""
      collection.each (each, index) ->
        out += options.fn _.extend each.toJSON(), {index, currentIdx: index is currentIndex}
      out

    @template = Handlebars.compile ($ '#queries-template').html()

    @model.get('predefinedQueries').on 'all', @render
    @model.on 'change:currentQuery', @render

  events:
    'click a[href^=/dossiers/]': 'onDossierClick'
    'click :button:contains("consulter")': 'onConsulterClick'
    'click :button:contains("actualiser")': 'onActualiserClick'

  render: =>
    context = {queries:[]}
    currentQuery = @model.get('currentQuery')
    @model.get('predefinedQueries').each (q) ->
      context.queries.push
        current: q.id is currentQuery.id
        query: q.toJSON()
        results: (q.get 'results')

    ($ @el).html @template context

  onDossierClick: (e) =>
    e.preventDefault()
    index = ($ e.target).data 'index'
    @model.get('currentQuery').at(index).fetch
      success: @model.setCurrentDossier

  onConsulterClick: (e) =>
    id = ($ e.target).data 'queryid'
    @model.set 'currentQuery', @model.get('predefinedQueries').get(id)

  onActualiserClick: (e) =>
    (@model.get 'currentQuery').refresh()
