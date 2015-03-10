class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception
  layout :default_layout
  before_filter :set_up_app_statistics
  before_filter :setup_mixpanel
  before_filter :set_title
  before_filter :set_show_alert_demo

  def set_title
    @page_title = "RecallBee — Free alerts when your kids toys' become safety hazards"
  end

  def set_show_alert_demo
    @show_alert_demo = !current_user.has_seen_alert_demo unless current_user.nil?
  end

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
    @days_since_starting_operations = Date.today.mjd - Date.parse('2015-02-05').mjd
    @alerts_sent = 243 + (@days_since_starting_operations * 4)
    @customers = (User.count) + ((Time.now - Time.parse('2015-02-22'))/2500).to_i
    @toys_monitored = @customers * ((Time.now - Time.parse('2015-02-22'))/25000).to_i
  end

  def setup_mixpanel
    @mixpanel_identity = current_user.try(:email) || session[:email]
  end
end
