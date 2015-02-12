class Api::VolatileSessionController < ApplicationController
  def email
    session[:email] = params[:email]
    head :ok
  end
end
