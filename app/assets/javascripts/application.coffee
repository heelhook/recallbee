#= require jquery
#= require jquery_ujs
#= require jquery-smooth-scroll
#= require twitter/bootstrap
#= require react/theme
#= require turbolinks
#= require sync
#= require_self

# Submit buttons outside of their form
$ ->
  $('body').on 'click', 'a[data-form][data-role="submit"]', (e) ->
    e.preventDefault()
    button = $(e.target)
    form = $("##{button.data().form}")
    form.submit()
