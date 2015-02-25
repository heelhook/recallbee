adjust_modal_max_height_and_position = ->
  $('.modal').each ->
    if $(this).hasClass('in') == false
      $(this).show()
    contentHeight = $(window).height() - 60
    headerHeight = $(this).find('.modal-header').outerHeight() or 2
    footerHeight = $(this).find('.modal-footer').outerHeight() or 2
    $(this).find('.modal-content').css 'max-height': ->
      contentHeight
    $(this).find('.modal-body').css 'max-height': ->
      contentHeight - headerHeight + footerHeight
    $(this).find('.modal-dialog').addClass('modal-dialog-center').css
      'margin-top': ->
        -($(this).outerHeight() / 2)
      'margin-left': ->
        -($(this).outerWidth() / 2)
    if $(this).hasClass('in') == false
      $(this).hide()
    return
  return

if $(window).height() >= 320
  $(window).resize(adjustModalMaxHeightAndPosition).trigger 'resize'
