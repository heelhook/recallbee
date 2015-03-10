class UserHasSeenAlertDemo < ActiveRecord::Migration
  def change
    add_column :users, :has_seen_alert_demo, :boolean, default: false
  end
end
