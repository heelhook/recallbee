$ ->
  $('#new-child.modal').on 'shown.bs.modal', (e) ->
    $('#new-child.modal #first-name').focus()

  $('#new-child.modal form').on 'ajax:send', (e) -> e.target.reset()

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
