class Api::GenderController < ApplicationController
  def guess
    gender = GenderGuesserService.guess(params[:name])

    render json: { gender: gender }
  end
end
