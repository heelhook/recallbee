$ ->
  $handler = StripeCheckout.configure
    key: "pk_test_Z1pNsWWw6Ajoe21V1dNkaO41"
    image: "https://stripe.com/img/documentation/checkout/marketplace.png"
    name: "Help keep kids safe"
    description: "Cancel at any time."
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
