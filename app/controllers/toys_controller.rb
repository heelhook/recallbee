class ToysController < ApplicationController
  enable_sync

  def create
    @toy = Toy.new(toy_params)
    authorize @toy
    @toy.save!

    head :no_content
  end

  private

  def toy_params
    params.require(:toy).permit(
      :name,
      :child_id,
    )
  end
end
