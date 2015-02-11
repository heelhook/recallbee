# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

class Sync.ChildDashboardItem extends Sync.View

  beforeInsert: ($el) ->
    $el.hide()
    @insert($el)
    $('#welcome-box').hide()

  afterInsert: ->
    @$el.fadeIn 'slow', =>
      $.smoothScroll
        scrollTarget: '#children-list .child:last'

  beforeRemove: ->
    @$el.fadeOut 'slow', => @remove()
    if $('#children-list .child').length is 0
      $('#welcome-box').removeClass('hidden')

class Sync.ToyItem extends Sync.View

  beforeInsert: ($el) ->
    $el.hide()
    @insert($el)
    $el.parents('.child.box').find('.intro').hide()

  afterInsert: ->
    @$el.fadeIn 'slow', =>
      update_toy_count(@$el)
      $.smoothScroll
        scrollTarget: $el

  beforeRemove: ->
    @$el.fadeOut 'slow', =>
      @remove()
      @update_toy_count($el)
    child_box = $el.parents('.child.box')
    if child_box.find('.toy-list .list-group-item').length is 0
      child_box.find('.intro').removeClass('hidden')

@update_toy_count = ($el) ->
  child_box = $el.parents('.child.box')
  toy_count = child_box.find('.toy-list .list-group-item').length
  string = if toy_count == 1 then "1 toy" else "#{toy_count} toys"
  child_box.find('h3 .note span[data-role="count"]').text(string)
