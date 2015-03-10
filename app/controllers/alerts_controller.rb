class AlertsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :load_resources

  def index
    @alerts = @child.alerts

    $mixpanel.track(current_user.email, 'View Alerts')
  end
  
  def show
  end

  def setup_demo
    if @child.alerts.empty?
      toy_report = ToyReport.first!
      @child.toy_ownerships.create!(toy: toy_report.toy)
    else
      @child.alerts.first.update_attributes(acknowledged_on: nil)
    end

    current_user.update_attributes(has_seen_alert_demo: true)
    session[:show_next_steps] = true

    head :ok
  end

  def destroy
    @alert.update_attributes!(acknowledged_on: Time.now)

    $mixpanel.track(current_user.email, 'Alert Acknowledged')

    redirect_to dashboard_path
  end

  private

  def load_resources
    @child = Child.where(slug: params[:child_id]).first! if params[:child_id]
    @alert = Alert.where(id: params[:id]).first if params[:id]
  end
end
