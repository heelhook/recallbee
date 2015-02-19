class Child < ActiveRecord::Base
  belongs_to :parent, class_name: 'User'
  has_many :toys, dependent: :destroy

  sync :all
  sync_scope :by_parent, -> (parent) { where(parent_id: parent.id) }

  validates :name, :parent_id, presence: true

  def pronoun
    case gender
    when 'female'; 'her'
    when 'male'; 'his'
    else
      'their'
    end
  end
end
