class ToyOwnershipPolicy
  attr_reader :user, :toy_ownership

  def initialize(user, toy_ownership)
    @user = user
    @toy_ownership = toy_ownership
  end

  def create?
    @toy_ownership.parent_id == @user.id
  end
end
