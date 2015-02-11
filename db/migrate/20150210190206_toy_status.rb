class ToyStatus < ActiveRecord::Migration
  def change
    add_column :toys, :status, :string, default: 'pending'
  end
end
