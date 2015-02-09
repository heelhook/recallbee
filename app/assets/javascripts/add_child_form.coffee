$ ->
  $('#new-child.modal').on 'shown.bs.modal', (e) ->
    $('#new-child.modal #first-name').focus()


  $('#new-child.modal form').on 'ajax:send', (e) -> e.target.reset()
