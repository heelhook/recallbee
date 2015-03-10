$ ->
  $('#moreinformation').on 'show.bs.collapse', (e) ->
    $('a[href="#moreinformation"]').slideUp()

  $('#moreinformation').on 'shown.bs.collapse', (e) ->
    mixpanel.track('Alert More Information Displayed')
