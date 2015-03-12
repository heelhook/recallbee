$ ->
  $('[data-toggle="tooltip"]').tooltip()

  $('body').on 'click', '[data-role="navigation-next"]', (e) ->
    if current_page_valid()
      change_page()
    false

  current_page_valid = ->
    switch $('.page:visible:first').data().id
      when 2
        if $('input#child_name').val().length < 3
          $('input#child_name')
            .addClass('invalid')
            .focus()
          return false
      when 3
        unless validate_email $('input#email').val()
          $('input#email')
            .addClass('invalid')
            .focus()
          return false
    true

  validate_email = (email) ->
      re = /[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+(?:[A-Z]{2}|com|org|net|gov|mil|biz|info|mobi|name|aero|jobs|museum)\b/
      re.test email

  $('body').on 'keypress', 'input', (e) ->
    if e.which == 13
      $('[data-role="navigation-next"]').click()
      false

  $('.page[data-id="2"]').on 'next', (e) ->
    update_child_name()
    update_child_pronoun()
    store_child_name()
    mixpanel.track('HIW Added Child Name', name: $('input#child_name').val())

  $('.page[data-id="3"]').on 'next', (e) ->
    record_email_address()
    mixpanel.track('HIW Added Email Address', email: $('input#email').val())

  store_in_volatile_session = (data) ->
    $.ajax
      url: '/api/volatile_session/store'
      method: 'put'
      data: data

  change_page = ->
    $next_id = $('.page:visible').next('.page').data().id
    $next_page = $(".page[data-id=\"#{$next_id}\"]")
    $('.page:visible').trigger('next')
    mixpanel.track "HIW", page: $next_id
    $('.page:visible').fadeOut =>
      $next_page.hide().removeClass('hidden').fadeIn =>
        $next_page.find('input:first').focus()

    unless $next_page.next('.page').length > 0
      $('[data-role="navigation-next"]').fadeOut()

  update_child_name = ->
    @child_name = $('input#child_name').val()
    $('span[data-role="child_name"]').text(@child_name)
    mixpanel.people.set "$child_name": @child_name

  update_child_pronoun = ->
    return unless @child_name?.length
    $.ajax
      url: '/api/gender/guess'
      data:
        name: @child_name
      success: (data) ->
        @child_gender = data.gender
        pronoun = switch data.gender
          when 'female' then 'her'
          when 'male' then 'his'
          else 'their'
        $('[data-role="child_pronoun"]').text(pronoun)

  store_child_name = ->
    store_in_volatile_session child_name: @child_name

  record_email_address = ->
    @user_email = $('input#email').val()

    mixpanel.alias @user_email
    mixpanel.people.set '$email': @user_email

    store_in_volatile_session 'email': @user_email
