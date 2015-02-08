class Child < ActiveRecord::Base
  belongs_to :parent, class_name: 'User'
  has_many :toys, dependent: :destroy

  validates :name, presence: true
end
