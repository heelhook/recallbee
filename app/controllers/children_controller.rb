class ChildrenController < ApplicationController
  enable_sync

  def create
    @child = Child.new(child_params)
    @child.parent = current_user
    @child.save!

    head :no_content
  end

  private

  def child_params
    params.require(:child).permit(
      :name,
      :birthday,
      :gender,
    )
  end
end
