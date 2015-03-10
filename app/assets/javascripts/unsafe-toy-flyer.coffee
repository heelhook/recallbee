$ ->
  $('#unsafe-toy-flyer').find('#first, #second, #third, .modal-footer').css(opacity: 0)

  $('#unsafe-toy-flyer').on 'shown.bs.modal', ->
    $('#first').delay(1000).animate(opacity: 1)
    $('#second').delay(2500).animate(opacity: 1)
    $('#third').delay(4000).animate(opacity: 1)
    $('.modal-footer').delay(5500).animate(opacity: 1)
    mixpanel.track('View Demo Flyer')

  $('#unsafe-toy-flyer').on 'hidden.bs.modal', ->
    mixpanel.track('Close Demo Flyer')
