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

