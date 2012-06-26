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
#= require Dossier
#= require ../collections/ResultSet

@OAQ = window.OAQ ? {}

class @OAQ.Query extends Backbone.Model
  idAttribute: '_id'
  urlRoot: '/queries'

  initialize: ->
    queryId = if @get('criteria') then 'libre' else @id
    @set 'results', new OAQ.ResultSet({queryId})

  execute: (callbacks={}) ->
    data = {}
    if @get('criteria')
      data.q = @get('criteria')
    (@get 'results').fetch
      data: data
      success: (results) =>
        callbacks.success?(results)

  next: (id, fn) ->
    # finds the index of the currentDossier in `results`. If it isn't the first
    # item, navigate the router to the previous dossier in `results`.
    index = @_indexOf id
    size = (@get 'results').size()
    if -1 < index < (size - 1)
      fn (@get 'results').at(index + 1).id
      
  prev: (id, fn) ->
    # finds the index of the currentDossier in `results`. If it isn't the last
    # item, navigate the router to the next dossier in `results`.
    index = @_indexOf id
    if index > 0
      fn (@get 'results').at(index - 1).id

  _indexOf: (id) ->
    indexFound = -1
    found = (@get 'results').find (test, index) ->
      indexFound = index
      test.id is id
    if found then indexFound else -1
