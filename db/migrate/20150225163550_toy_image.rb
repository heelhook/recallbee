class ToyImage < ActiveRecord::Migration
  def change
    add_column :toys, :image, :string
    add_column :toys, :upc, :string
    add_column :toys, :descriptions, :string
    add_column :toys, :minimum_age_months, :integer
    add_column :toys, :maximum_age_months, :integer
    add_column :toys, :provider, :string
  end
end
