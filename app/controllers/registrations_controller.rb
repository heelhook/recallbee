class RegistrationsController < Devise::RegistrationsController
  protected

  def after_sign_up_path_for(resource)
    if CompleteUserPolicy.new(current_user).complete?
      dashboard_path
    else
      edit_user_registration_path
    end
  end
end
