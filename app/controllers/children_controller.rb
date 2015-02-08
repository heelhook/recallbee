class ChildrenController < ApplicationController
  respond_to :json

  def create
    @child = Child.new(child_params)
    @child.parent = current_user
    @child.save!

    respond_with @child
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
