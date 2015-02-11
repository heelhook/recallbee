class Api::GenderController < ApplicationController
  def guess
    name = Gendered::Name.new(params[:name])
    name.guess!

    render json: { gender: name.gender }
  end
end
