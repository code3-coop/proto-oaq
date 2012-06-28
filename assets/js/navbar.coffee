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
#= require vendor/socket.io
#= require vendor/bootstrap
#= require extensions/bootstrap-popover

$ ->

  btn = ($ '.x-btn-messages')

  adjustColor = (count) ->
    switch count
      when 0 then btn.html("aucun message non-lu").removeClass('btn-warning').addClass('btn-success')
      when 1 then btn.html("1 message non-lu").addClass('btn-warning')
      else btn.html("#{count} messages non-lus").addClass('btn-warning')

  socket = io.connect '/'
  socket.on 'change:unread', adjustColor

  btn.on 'click', ->
    window.location = '/messages'
    no # propagation

  $.ajax
    url: '/messages/nonlu'
    dataType: 'json'
    success: (data) ->
      btn.popover
        placement: 'bottom'
        title: 'Messages non-lus'
        content: ->
          html = ""
          for each in data
            html += "<li><img class='pull-left' src='http://www.gravatar.com/avatar/7e48cdee24a5707ea4ed47e8465496be?s=30&d=mm'><span>#{each.subject}</span></li>"
          html

