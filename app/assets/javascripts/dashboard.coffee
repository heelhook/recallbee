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
    child_box = $el.parents('.child.box')
    child_box.find('.intro').hide()
    child_box.removeClass('empty')

  afterInsert: ->
    update_button(@$el)
    @$el.fadeIn 'slow', =>
      update_toy_count(@$el)

  beforeRemove: ->
    update_button(@$el)
    @$el.fadeOut 'slow', =>
      @remove()
      update_toy_count(@$el)
    
  update_toy_count = ($el) ->
    child_box = $el.parents('.child.box')
    toy_count = child_box.find('.toy-list .list-group-item').length
    string = if toy_count == 1 then "1 toy" else "#{toy_count} toys"
    child_box.find('h3 .note span[data-role="count"]').text(string)

  update_button = ($el) ->
    child_box = $el.parents('.child.box')
    btn = child_box.find('a[data-role="new-toy"]')

    if child_box.find('.toy-list .list-group-item').length is 0
      child_box.addClass('empty')
      name = btn.data().childname
      btn_text = "Add #{name}'s first toy"
    else
      btn_text = "Add another toy"
    btn.text(btn_text)
