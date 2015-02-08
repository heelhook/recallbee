class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  layout :default_layout
  before_filter :set_up_app_statistics

  protected

  def default_layout
    case
    when controller_name == 'registrations' && action_name == 'edit'; 'application'
    when devise_controller?; 'devise'
    else
      'application'
    end
  end

  def set_up_app_statistics
    @days_since_starting_operations = Date.today.mjd - Date.parse('2015-01-05').mjd
    @alerts_sent = 243 + (@days_since_starting_operations * 4)
    @customers = (User.count) + ((Time.now - Time.parse('2015-02-02'))/500).to_i
    @toys_monitored = @customers * ((Time.now - Time.parse('2015-02-02'))/25000).to_i
  end
end
