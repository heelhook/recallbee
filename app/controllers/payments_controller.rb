class PaymentsController < ApplicationController
  layout :layout

  def new
  end

  def create
    customer = Stripe::Customer.create(
      source: params[:stripe_token][:id],
      plan: params[:plan],
      email: params[:stripe_token][:email],
    )

    current_user.update_attributes!(
      stripe_token: customer.id
    )

    head :ok
  end

  def show
    return if current_user.stripe_token.blank?

    stripe_customer = Stripe::Customer.retrieve(current_user.stripe_token)
    @stripe_subscription = stripe_customer.subscriptions.all.data[0]
  end

  def destroy
    return if current_user.stripe_token.blank?

    stripe_customer = Stripe::Customer.retrieve(current_user.stripe_token)
    stripe_customer.subscriptions.first.delete

  ensure
    redirect_to subscription_path
  end

  protected

  def layout
    if current_user
      'application'
    else
      'landing'
    end
  end
end
