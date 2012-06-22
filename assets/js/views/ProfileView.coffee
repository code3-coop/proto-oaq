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
#= require ../vendor/md5
#= require ../vendor/moment
#= require ../vendor/moment-fr
#= require ../vendor/dotdotdot

moment.lang 'fr'

@OAQ = window.OAQ ? {}

class @OAQ.ProfileView extends Backbone.View
  initialize: ->
    @template = Handlebars.compile ($ '#profile-info-template').html()
    @model.on 'change:currentDossier', @render

  render: =>
    dossier = @model.get('currentDossier')
    adresse = dossier.get('adresses')[0]
    note = dossier.get('notes')?[0]
    context =
      dossier: dossier.toJSON()
      imgUrl: "http://www.gravatar.com/avatar/#{CryptoJS.MD5(adresse.courriel)}?s=57&d=#{window.encodeURIComponent(window.location.origin+'/img/avatar.png')}"
      adresse: adresse
    if note
      context.note =
        dateCreation: moment(note.dateCreation).fromNow()
        contenu: note.contenu
        auteur: note.auteur
    ($ @el).html @template context
    @$('.x-body').dotdotdot
      height: 60
