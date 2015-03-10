$ ->
  $('#next-actions-flyer').on 'click', '.action img, .action h4', (e) ->
    selected_item = $(e.target).parents('.action')
    id = selected_item.data().id

    $('#next-actions-flyer .action').removeClass('unselected selected')
    $('#next-actions-flyer .actions').addClass('selection')
    selected_item.addClass('selected')

    if $('#next-actions-flyer').is(':visible')
      $("#next-actions-flyer .slides .slide[id!='#{id}']:visible").slideUp()
      $("#next-actions-flyer .slides .slide[id='#{id}']:not(:visible)").slideDown()
    else
      $("#next-actions-flyer .slides .slide[id!='#{id}']").hide()
      $("#next-actions-flyer .slides .slide[id='#{id}']").show()

  $('#next-actions-flyer').on 'show.bs.modal', (e) ->
    child_name = $('#children-list [data-childname]:first').data().childname
    $('#next-actions-flyer [data-role="child_name"]').text(child_name)
