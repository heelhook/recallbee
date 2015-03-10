class AlertReport < ActiveRecord::Migration
  def change
    remove_column :alerts, :toy_id
    add_column :alerts, :report_id, :integer
  end
end
