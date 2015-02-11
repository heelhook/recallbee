class AddChildrenBirthday < ActiveRecord::Migration
  def change
    add_column :children, :birthday, :date
  end
end
