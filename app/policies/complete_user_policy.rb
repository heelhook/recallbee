class CompleteUserPolicy
  def initialize(user)
    @user = user
  end

  def complete?
    ! @user.email.blank? &&
    ! @user.first_name.blank? &&
    ! @user.last_name.blank?
  end
end
