# *= require landing

$ ->
  $('#show_form').on 'click', ->
    $('#show_form').hide()
    $('#form').removeClass('hidden')
    false
