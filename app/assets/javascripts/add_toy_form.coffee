$ ->
  #
  # Modal
  #
  $('#new-toy.modal').on 'show.bs.modal', -> reset_form()

  $('#children-list').on 'click', 'a[data-role="new-toy"]', (e) ->
    setup_form(e)
    $('#new-toy.modal').modal('show')

  reset_form = ->
    $('#new-toy .toylist#search-results').html('')
    $('#new-toy .toylist#suggestions').show()
    $('#new-toy #search').val('')

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

  # 
  # List interaction
  # 

  # Send selection
  $('#new-toy.modal form').on 'ajax:send', (e) ->
    toy_count = $('.toylist a.isotope-item.selected').length
    childid = $(e.target).data().childid
    $("[data-childid='#{childid}']").trigger 'new_toys', toy_count

    e.target.reset()
    $('#new-toy.modal').modal('hide')
    mixpanel_track()

  # Send selection
  $('#new-toy.modal').on 'click', 'a.btn-primary[data-role="submit"]', (e) ->
    $('#new-toy.modal').modal('hide')
    childid = $('#new-toy [data-role="child-id"]').val()
    $('#new-toy form').submit()
    return false
  
  # Select a toy from the list
  $('body').on 'click', '.toylist a.isotope-item', (e) ->
    item = $(e.target).parents('.isotope-item')
    item.toggleClass('selected')
    toyid = item.data().toyid
    sel = item.hasClass('selected')
    $("#new-toy input[name='toys[#{toyid}]']").val(sel)
    set_button_state()
    return false

  set_button_state = ->
    if $('.toylist .isotope-item.selected').length == 0
      $('#new-toy a[data-role="submit"]')
        .addClass('btn-outline')
        .removeClass('btn-primary')
    else
      $('#new-toy a[data-role="submit"]')
        .removeClass('btn-outline')
        .addClass('btn-primary')


  #
  # Search
  #
  # Send search
  $('#new-toy.modal').on 'keypress', '#search', (e) ->
    return true unless e.which == 13

    $('#new-toy.modal #search-btn').click()
    false

  # Search button used
  $('#new-toy.modal #search-btn').on 'click', (e) ->
    term = $('#new-toy.modal #search').val()
    $.ajax
      url: '/toys'
      method: 'post'
      data:
        q: term
      beforeSend: => setup_search()
      complete: -> complete_search()
      success: (data) -> successful_search(data)
    false

  $('#new-toy.modal .search .suggestions a').on 'click', (e) ->
    text = $(e.target).text()
    $('#new-toy.modal #search').val(text)
    $('#new-toy.modal #search-btn').click()
    false

  setup_search = ->
    label = $('#new-toy.modal #search-btn span')
    label.removeClass('fa-search').addClass('fa-circle-o-notch fa-spin')
    $('.toylist#suggestions').fadeOut()
    $('.toylist#search-results').slideUp()
    $('#new-toy.modal .modal-footer').slideUp()

  complete_search = ->
    label = $('#new-toy.modal #search-btn span')
    label.addClass('fa-search').removeClass('fa-circle-o-notch fa-spin')
    $('.toylist#search-results').slideDown -> $(window).resize()
    if $('.toylist#search-results .isotope-item').length is 0
      $('.toylist#suggestions').slideDown -> $(window).resize()
    $('#new-toy.modal .modal-footer').slideDown()

  successful_search = (data) ->
    if $('.toylist#search-results .isotope-item').length isnt 0
      $('.toylist#suggestions').slideUp()
    result = data.map (item) ->
      """
      <input type="hidden" name="toys[#{item.id}]" value="false" />
      <a class="isotope-item" href="#" data-toyid="#{item.id}">
        <span class="image"><img src="#{item.image}" /></span>
        <span class="toy-name">#{item.name}</span>
      </a>
      """
    $('.toylist#search-results').html(result.join(''))

  # 
  # Utils
  # 
  mixpanel_track = ->
    mixpanel.track('Created New Toy')
    toy_count = $('.toylist a.isotope-item.selected').length
    mixpanel.people.increment('Toy Count', toy_count)
