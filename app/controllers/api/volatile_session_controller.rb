class Api::VolatileSessionController < ApplicationController
  def store
    volatile_session_params.each do |key, value|
      session[key] = value
    end

    head :ok
  end

  private

  def volatile_session_params
    params.permit(
      :email,
      :child_name,
      :child_gender,
    )
  end
end
