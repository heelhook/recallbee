#= require add_child_form
#= require add_toy_form
#= require unsafe-toy-flyer
#= require next-actions

$ ->
  show_demo_hint()

  $('body').on 'click', '.child.box .box-contents img#psst', (e) -> $(e.target).fadeOut(1000)

  $('body').on 'click', '.child.box .box-contents a[data-role="unsafe-demo"]', (e) ->
    activate_demo($(e.target).parents('.child.box'))

  $('body').on 'click', '.sidebar a[data-role="unsafe-demo"]', (e) ->
    $.smoothScroll
      scrollTarget: '#children-list .child:first'

    $('.child.box .box-contents a[data-role="unsafe-demo"]')[0].click()
    return false

  $('body').on 'click', '.sidebar a[data-target="#next-actions-flyer"]', (e) ->
    href = $(e.target).parents('a').attr('href')
    $("#next-actions-flyer .actions .action[href='#{href}'] h4").click()

  $('body').on 'new_toys', '.child.box', (e, toy_count) ->
    child_box = $(e.target)
    if child_box.hasClass('empty')
      child_box.find('.safe').hide()
      child_box.find('.empty').fadeOut 'slow', =>
        child_box
          .removeClass('empty')
          .addClass('safe')
        child_box.find('.safe').fadeIn('slow')
        show_demo_hint()

    update_toy_count(child_box, toy_count)

activate_demo = (child_box) ->
  child_id = child_box.data().childid
  child_name = child_box.data().childname

  $('.child.box .box-contents img#psst').fadeOut 250, =>
    child_box.find('.safe').slideUp =>
      $('#unsafe-toy-flyer [data-role="child_name"]').text(child_name)
      $('#unsafe-toy-flyer').modal('show')
      child_box.removeClass('safe')
      child_box.find('.unsafe').hide()
      child_box.addClass('unsafe')
      child_box.find('.unsafe').slideDown()


  $.ajax
    url: "/children/#{child_id}/alerts/setup_demo"
    method: 'post'

  return false

update_toy_count = (child_box, toy_count) ->
  toy_count_div = child_box.find('.toy-count')
  count = child_box.find('span[data-role="toy-count"]')
  total_count = parseInt(count.data().count) + toy_count

  string = if total_count == 1 then "1 toy" else "#{total_count} toys"
  count.text(string)    
  count.attr('data-count', total_count)
  console.log toy_count_div
  toy_count_div.addClass('updating')
  setTimeout =>
    toy_count_div.removeClass('updating')
  , 5000


show_demo_hint = ->
  setTimeout ->
    $('.child.box:not(.empty) .box-contents img#psst').fadeIn 1000
  , 2000

class Sync.ChildDashboardItem extends Sync.View

  beforeInsert: ($el) ->
    $el.hide()
    $('#welcome-box').slideUp =>
      @insert($el)

  afterInsert: ->
    @$el.slideDown 'slow', =>
      $.smoothScroll
        scrollTarget: '#children-list .child:last'

  beforeRemove: ->
    @$el.fadeOut 'slow', => @remove()
    if $('#children-list .child').length is 0
      $('#welcome-box').removeClass('hidden')
