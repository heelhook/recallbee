class Child < ActiveRecord::Base
  belongs_to :parent, class_name: 'User'
  has_many :toys

  validates :name, presence: true
end
