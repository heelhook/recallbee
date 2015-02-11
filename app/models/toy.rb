class Toy < ActiveRecord::Base
  belongs_to :child
  has_one :parent, through: :child

  delegate :id, to: :parent, prefix: true, allow_nil: true

  sync :all
  sync_scope :by_child, -> (child) { where(child_id: child.id) }
end
