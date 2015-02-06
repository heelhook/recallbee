class RegistrationsController < Devise::RegistrationsController
  protected

  def after_sign_up_path_for(resource)
    if CompleteUserPolicy.new(current_user).complete?
      '/dashboard'
    else
      '/profile'
    end
  end
end
