class Toy < ActiveRecord::Base
  belongs_to :child
  has_one :parent, through: :child

  delegate :id, to: :parent, prefix: true, allow_nil: true

  validates :name, presence: true

  sync :all
  sync_scope :by_child, -> (child) { where(child_id: child.id) }

  serialize :descriptions, Array

  def self.search_one(upc)
    toy = Toy.where(upc: upc).first
    return toy if toy

    toys = ToySearchService.search(upc)
    toys.each {|toy| toy.save }
    toys.first
  end
end
