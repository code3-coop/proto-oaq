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

  defaults:
    index: 0
    label: ''

  initialize: ->
    @set 'results', new OAQ.ResultSet(queryId:@id)

  refresh: (callbacks={}) ->
    (@get 'results').fetch(callbacks)

  current: ->
    (@get 'results').at(@get 'index')

  next: ->
    index = @get 'index'
    @set('index', index + 1) if index < (@get 'results').size() - 1
    @current()

  prev: ->
    index = @get 'index'
    @set('index', index - 1) if index > 0
    @current()
