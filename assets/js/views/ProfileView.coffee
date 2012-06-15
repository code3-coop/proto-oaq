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

#= require ../vendor/md5

@OAQ = window.OAQ ? {}

class @OAQ.ProfileView extends Backbone.View
  initialize: ->
    @template = Handlebars.compile ($ '#profile-info-template').html()
    @model.on 'change', @render

  render: =>
    adresse = @model.get('adresses')[0]
    note = @model.get('notes')[0]
    ($ @el).html @template
      dossier: @model.toJSON()
      imgUrl: "http://www.gravatar.com/avatar/#{CryptoJS.MD5(adresse.courriel)}?s=57&d=#{window.encodeURIComponent(window.location+'/img/avatar.png')}"
      adresse: adresse
      note: note
