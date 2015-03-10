class ToyRemoveChildId < ActiveRecord::Migration
  def change
    remove_column :toys, :child_id
  end
end
