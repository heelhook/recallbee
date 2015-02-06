class CreateToys < ActiveRecord::Migration
  def change
    create_table :toys do |t|
      t.references :child, index: true
      t.string :name
      t.string :added_via

      t.timestamps null: false
    end
    add_foreign_key :toys, :children
  end
end
