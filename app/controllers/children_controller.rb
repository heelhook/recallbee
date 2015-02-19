class ChildrenController < ApplicationController
  enable_sync

  def create
    @child = Child.new(child_params)
    @child.save!

    head :no_content
  end

  private

  def child_params
    params.require(:child).permit(
      :name,
      :birthday,
      :gender,
    ).merge(
      parent_id: current_user.id,
    )
  end
end
