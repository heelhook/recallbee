class ToyOwnershipsController < ApplicationController
  def create
    child = Child.where(slug: params[:child_id]).first

    params[:toys].each do |toy_id, boolean|
      if boolean == 'true'
        toy_ownership = child.toy_ownerships.new(
          toy_id: toy_id,
        )

        authorize toy_ownership
        toy_ownership.save!
      end
    end

    head :no_content
  end

  private

  def toy_ownership_params
    params.require(:toy_ownership).permit(
      :name,
      :child_id,
    )
  end
end
