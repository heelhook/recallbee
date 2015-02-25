$ ->
  $('body').on 'click', '.toylist a.isotope-item', (e) ->
    $(e.target).parents('.isotope-item').toggleClass('selected')
    return false
