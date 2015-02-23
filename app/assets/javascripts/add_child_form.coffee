$ ->
  $('#new-child.modal').on 'shown.bs.modal', (e) ->
    $('#new-child.modal #child_name').focus()

  $('#new-child.modal input').on 'keypress', (e) ->
    if e.which == 13
      $(e.target).parents('form').submit()
      return false

  $('#new-child.modal form').on 'ajax:send', (e) ->
    name = $('#new-child.modal form #child_name').val()
    e.target.reset()
    $('#new-child.modal').modal('hide')
    if name?
      mixpanel.track('Created New Child')
      mixpanel.people.increment('Child Count')
      mixpanel.people.set "$child_name": name
      mixpanel.people.append '$children_names', name

  $('#new-child.modal form #child_name').on 'blur', (e) ->
    name = $('#new-child.modal form #child_name').val()
    return unless name?.length
    $.ajax
      url: '/api/gender/guess'
      data:
        name: name
      success: (data) ->
        switch data.gender
          when 'female', 'male'
            $("#new-child.modal form input#child_gender_#{data.gender}").prop('checked', true)
          else
            $("#new-child.modal form input#child_gender_female").prop('checked', false)
            $("#new-child.modal form input#child_gender_male").prop('checked', false)
