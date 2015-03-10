class ChangeAlertAcknowledgedOnType < ActiveRecord::Migration
  def change
    remove_column :alerts, :acknowledged_on
    add_column :alerts, :acknowledged_on, :datetime
  end
end
