class Toy < ActiveRecord::Base
  has_many :reports, class_name: 'ToyReport'

  validates :name, presence: true

  serialize :descriptions, Array

  def self.search_one(upc)
    toy = Toy.where(upc: upc).first
    return toy if toy

    toys = ToySearchService.search(upc)
    toys.each {|toy| toy.save }
    toys.first
  end
end
