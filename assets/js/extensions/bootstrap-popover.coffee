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
#= require ../vendor/bootstrap

# Monkey patch popover so that it doesn't spill outside of the browser frame.

$.fn.popover.Constructor::getPosition = (inside) ->
  offset = if inside then {top:0, left:0} else @$element.offset()
  offset.left += 18
  dimensions = {width: @$element[0].offsetWidth, height: @$element[0].offsetHeight}
  $.extend {}, offset, dimensions

# Replace the default template.

$.fn.popover.defaults.template = "<div class='popover'><div class='arrow'></div><div class='popover-inner'><h3 class='popover-title'></h3><div class='popover-content'><ul></ul></div></div></div>"
