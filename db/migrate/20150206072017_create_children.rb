class CreateChildren < ActiveRecord::Migration
  def change
    create_table :children do |t|
      t.references :parent
      t.string :name

      t.timestamps null: false
    end
  end
end
