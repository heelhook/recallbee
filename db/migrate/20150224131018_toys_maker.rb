class ToysMaker < ActiveRecord::Migration
  def change
    add_column :toys, :maker, :string
  end
end
