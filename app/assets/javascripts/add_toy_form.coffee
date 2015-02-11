$ ->
  $('button[data-role="new-toy"][data-childid]').on 'click', (e) ->
    name = $(e.target).data().childname
    id = $(e.target).data().childid

    $('#new-toy [data-role="child-name"]').text(name)
    $('#new-toy [data-role="child-id"]').val(id)
  $('#new-toy.modal').on 'shown.bs.modal', (e) ->
    $('#new-toy.modal #first-name').focus()

  $('#new-toy.modal form').on 'ajax:send', (e) ->
    e.target.reset()
    $('#new-toy.modal').modal('hide')
