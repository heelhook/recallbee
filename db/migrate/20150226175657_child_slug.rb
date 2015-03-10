class ChildSlug < ActiveRecord::Migration
  def change
    add_column :children, :slug, :string, unique: true
    add_index :children, :slug, unique: true
  end
end
