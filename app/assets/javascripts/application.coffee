#= require jquery
#= require jquery_ujs
#= require jquery-smooth-scroll
#= require twitter/bootstrap
#= require turbolinks
#= require onboarding
#= require add_child_form
#= require add_toy_form
#= require sync
#= require dashboard
#= require_self

# Submit buttons outside of their form
$ ->
  $('body').on 'click', 'a[data-form][data-role="submit"]', (e) ->
    e.preventDefault()
    button = $(e.target)
    form = $("##{button.data().form}")
    form.submit()
