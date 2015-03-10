$ ->
  $('#children-list').on 'click', 'a[data-role="new-toy"]', (e) ->
    setup_form(e)
    $('#new-toy.modal').modal('show')

  $('#new-toy.modal form').on 'ajax:send', (e) ->
    toy_count = $('.toylist a.isotope-item.selected').length
    childid = $(e.target).data().childid
    $("[data-childid='#{childid}']").trigger 'new_toys', toy_count

    e.target.reset()
    $('#new-toy.modal').modal('hide')
    mixpanel_track()

  $('#new-toy.modal').on 'click', 'a.btn-primary[data-role="submit"]', (e) ->
    $('#new-toy.modal').modal('hide')
    childid = $('#new-toy [data-role="child-id"]').val()
    $('#new-toy form').submit()
    return false
    
  $('body').on 'click', '.toylist a.isotope-item', (e) ->
    item = $(e.target).parents('.isotope-item')
    item.toggleClass('selected')
    toyid = item.data().toyid
    sel = item.hasClass('selected')
    $("#new-toy input[name='toys[#{toyid}]']").val(sel)
    set_button_state()
    return false

  setup_form = (e) ->
    child_box = $(e.target).parents('.child.box')
    name = child_box.data().childname
    gender = child_box.data().childgender
    id = child_box.data().childid

    $('#new-toy form#new_toy')
        .attr('action', "/children/#{id}/toys")
        .attr('data-childid', id)

    $('#new-toy [data-role="child-gender"]').text(gender)
    $('#new-toy [data-role="child-name"]').text(name)
    $('#new-toy [data-role="child-id"]').val(id)

    $('#new-toy.modal .isotope-item').hide()
    $("#new-toy.modal .isotope-item.#{gender}").show()

    $('#new-toy.modal #toy_name').focus()
    $('#new-toy .selected').removeClass('selected')
    $('#new-toy input[name^=toys][value="true"]').val(false)

    set_button_state()

  mixpanel_track = ->
    mixpanel.track('Created New Toy')
    toy_count = $('.toylist a.isotope-item.selected').length
    mixpanel.people.increment('Toy Count', toy_count)

  set_button_state = ->
    if $('.toylist .isotope-item.selected').length == 0
      $('#new-toy a[data-role="submit"]')
        .addClass('btn-outline')
        .removeClass('btn-primary')
    else
      $('#new-toy a[data-role="submit"]')
        .removeClass('btn-outline')
        .addClass('btn-primary')
