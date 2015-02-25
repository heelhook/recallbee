$ ->
  $('#children-list').on 'click', '[data-role="new-toy"][data-childid]', (e) ->
    name = $(e.target).data().childname
    gender = $(e.target).data().childgender
    id = $(e.target).data().childid

    $('#new-toy [data-role="child-gender"]').text(gender)
    $('#new-toy [data-role="child-name"]').text(name)
    $('#new-toy [data-role="child-id"]').val(id)

    $('#new-toy.modal .suggestions li').hide()
    $("#new-toy.modal .suggestions li.#{gender}").show()

  $('#new-toy.modal').on 'shown.bs.modal', (e) ->
    $('#new-toy.modal #toy_name').focus()

  $('#new-toy.modal').on 'click', '.suggestions li a', (e) ->
    name = $(e.target).data().name
    maker = $(e.target).data().maker
    $('#new-toy input#toy_name').val(name)
    $('#new-toy input#toy_maker').val(maker)
    return false

  $('#new-toy.modal form').on 'ajax:send', (e) ->
    e.target.reset()
    $('#new-toy.modal').modal('hide')
    mixpanel.track('Created New Toy')
    mixpanel.people.increment('Toy Count')
    
