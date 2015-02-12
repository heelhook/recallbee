$ ->
  $('[data-role="navigation-next"]').on 'click', (e) -> change_page()

  $('input#child_name').on 'change', (e) ->
    update_child_name()
    update_child_pronoun()

  $('input#email').on 'change', (e) -> record_email_address()

  change_page = ->
    $next_id = $('.page:visible').data().next
    $('.page:visible').fadeOut =>
      page = $(".page[data-id=\"#{$next_id}\"]")
      page.hide().removeClass('hidden').fadeIn =>
        page.find('input:first').focus()

  update_child_name = ->
    child_name = $('input#child_name').val()
    $('span[data-role="child_name"]').text(child_name)

  update_child_pronoun = ->
    name = $('input#child_name').val()
    return unless name?.length
    $.ajax
      url: '/api/gender/guess'
      data:
        name: name
      success: (data) ->
        switch data.gender
          when 'female'
            $('[data-role="child_pronoun"]').text('her')
          when 'male'
            $('[data-role="child_pronoun"]').text('his')
          else
            $('[data-role="child_pronoun"]').text('their')

  record_email_address = ->
    email = $('input#email').val()
    $.ajax
      url: '/api/volatile_session/email'
      data:
        email: email
