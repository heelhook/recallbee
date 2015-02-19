class RegistrationsController < Devise::RegistrationsController
  before_filter :configure_permitted_parameters

  def new
    build_resource(
      first_name: session[:first_name],
      last_name: session[:last_name],
      email: session[:email],
    )

    @sign_up_button_text = ab_test('sign up button',
      "Start protecting my kids",
      "Create my free account"
    )
  end

  protected

  def after_sign_up_path_for(resource)
    $mixpanel.track(current_user.email, 'Sign Up')
    finished('sign up button')
    
    if session['child_name']
      unless current_user.children.where(name: session['child_name']).exists?
        current_user.children.create(
          name: session['child_name'],
          gender: guess_child_gender,
        )
        $mixpanel.people.increment(current_user.email, 'Child Count' => 1)
      end
    end

    if CompleteUserPolicy.new(current_user).complete?
      dashboard_path
    else
      edit_user_registration_path
    end
  end

  def guess_child_gender
    gender = GenderGuesserService.guess(session['child_name'])
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up).push(
      :first_name,
      :last_name,
    )
  end
end
