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
#= require navbar

$ ->
  
  markAsRead = (btn) ->
    $.ajax
      type: 'PUT'
      url: "/messages/#{btn.data('id')}"
      data:
        isRead:'true'
      success: =>
        btn.closest('.row').next().andSelf().css('opacity', '.5')
        btn.remove()

  ($ '.x-mark-read').on 'click', (e) ->
    markAsRead $ e.target
    no # propagation

  ($ '.x-mark-all-read').on 'click', (e) ->
    ($ '.x-mark-read').each (idx, each) ->
      markAsRead $ each
    no # propagation

