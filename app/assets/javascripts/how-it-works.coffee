$ ->
  $('body').on 'click', '[data-role="navigation-next"]', (e) ->
    change_page()
    false

  $('.page[data-id="2"]').on 'next', (e) ->
    update_child_name()
    update_child_pronoun()
    store_child_name()
    mixpanel.track('HIW Added Child Name')

  $('.page[data-id="3"]').on 'next', (e) ->
    record_email_address()
    mixpanel.track('HIW Added Email Address')

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
