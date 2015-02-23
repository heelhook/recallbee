# *= require landing

$ ->
  $('input#user_first_name').on 'change', (e) -> mixpanel.people.set '$first_name': $(e.target).val()
  $('input#user_last_name').on 'change', (e) -> mixpanel.people.set '$last_name': $(e.target).val()
  $('input#user_email').on 'change', (e) -> mixpanel.people.set '$email': $(e.target).val()
  $('form#new_user').on 'submit', (e) -> mixpanel.alias $('input#user_email').val()
