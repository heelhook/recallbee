class CreateToyOwnerships < ActiveRecord::Migration
  def change
    create_table :toy_ownerships do |t|
      t.references :toy, index: true
      t.references :child, index: true

      t.timestamps null: false
    end
    add_foreign_key :toy_ownerships, :toys
    add_foreign_key :toy_ownerships, :children
  end
end
