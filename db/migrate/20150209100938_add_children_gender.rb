class AddChildrenGender < ActiveRecord::Migration
  def change
    add_column :children, :gender, :string
  end
end
