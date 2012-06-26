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

#= require ../vendor/underscore
#= require ../vendor/backbone
#= require ../models/Dossier

@OAQ = window.OAQ ? {}

class @OAQ.Router extends Backbone.Router
  routes:
    'dossiers/:id' : 'findDossier'


  findDossier: (id) ->
    new OAQ.Dossier(_id:id).fetch
      success: (found) =>
        OAQ.app.set 'currentDossier', found
      error: =>
        @navigate('/', {trigger:yes})
