class ToyPolicy
  attr_reader :user, :toy

  def initialize(user, toy)
    @user = user
    @toy = toy
  end

  def create?
    @toy.parent_id == @user.id
  end
end
