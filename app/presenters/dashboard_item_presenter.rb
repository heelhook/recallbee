class DashboardItemPresenter
  def self.determine_class(child, show_alert_demo)
    classes = []

    classes << (child.gender || "female")

    classes << case
      when child.toys.empty?
        'empty'
      when child.unacknowledged_alerts.any?
        'unsafe'
      else
        'safe'
      end

    classes << 'demo' if show_alert_demo

    classes.join(' ')
  end
end
