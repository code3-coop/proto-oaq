#= require vendor/jquery
#= require vendor/socket.io

$ ->

  btn = ($ '.x-btn-messages')

  adjustColor = (count) ->
    switch count
      when 0 then btn.html("aucun message non-lu").removeClass('btn-warning').addClass('btn-success')
      when 1 then btn.html("1 message non-lu").addClass('btn-warning')
      else btn.html("#{count} messages non-lus").addClass('btn-warning')

  (io.connect '/').on 'change:unreadCount', adjustColor

  btn.on 'click', ->
    window.location = '/messages'
    no # propagation
