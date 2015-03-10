class CreateAlerts < ActiveRecord::Migration
  def change
    create_table :alerts do |t|
      t.references :child, index: true
      t.references :toy, index: true
      t.time :acknowledged_on

      t.timestamps null: false
    end
    add_foreign_key :alerts, :children
    add_foreign_key :alerts, :toys
  end
end
