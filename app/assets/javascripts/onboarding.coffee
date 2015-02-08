# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('#onboarding #tabs .tab-pane a.button[data-toggle="continue"]').on 'click', (e) ->
    e.preventDefault()
    console.log $(e.target).attr('href')
    panel = $('#tabs '+$(e.target).attr('href')+'.tab-pane')
    console.log $(panel)
    $(panel).tab('show')
    return false
