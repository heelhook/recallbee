$ ->
  stripe_api_public = $('#stripe_key').val()

  $handler = StripeCheckout.configure
    key: stripe_api_public
    image: "https://stripe.com/img/documentation/checkout/marketplace.png"
    name: "Keeping Kids Safe"
    description: "Enter your details to continue"
    email: $('#user_email').val()
    panelLabel: "Support Kids' Safety"
    allowRememberMe: false
    token: (token) ->
      mixpanel.track('Stripe Checkout submitted')
      $.ajax
        url: '/payments'
        method: 'post'
        data:
          plan: $('#amount-of-subscription').val()
          stripe_token: token
        complete: ->
          $(location).attr('href', '/subscription')
    opened: -> mixpanel.track('Stripe Checkout opened')
    closed: -> mixpanel.track('Stripe Checkout closed')

  $('#stripe-subscribe-button').on 'click', (e) -> $handler.open()
