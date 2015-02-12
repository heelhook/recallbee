class RegistrationsController < Devise::RegistrationsController
  def new
    build_resource({ email: session[:email] })
    debugger
    true
  end

  protected

  def after_sign_up_path_for(resource)
    if CompleteUserPolicy.new(current_user).complete?
      dashboard_path
    else
      edit_user_registration_path
    end
  end
end
