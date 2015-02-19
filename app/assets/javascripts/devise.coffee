# *= require landing

$ ->
  $('input#user_first_name').on 'change', (e) -> mixpanel.people.set '$first_name': $(e.target).val()
  $('input#user_last_name').on 'change', (e) -> mixpanel.people.set '$last_name': $(e.target).val()
