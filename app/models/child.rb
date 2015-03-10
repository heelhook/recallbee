class Child < ActiveRecord::Base
  include FriendlyId
  friendly_id :slug_candidates, use: :slugged

  belongs_to :parent, class_name: 'User'
  has_many :toy_ownerships, dependent: :destroy
  has_many :toys, through: :toy_ownerships
  has_many :alerts, -> { order 'acknowledged_on ASC' }, dependent: :destroy
  has_many :unacknowledged_alerts, -> { where 'acknowledged_on IS NULL' }, class_name: 'Alert', dependent: :destroy
  has_many :acknowledged_alerts, -> { where 'acknowledged_on IS NOT NULL' }, class_name: 'Alert', dependent: :destroy

  sync :all
  sync_scope :by_parent, -> (parent) { where(parent_id: parent.id) }

  validates :name, :parent_id, presence: true

  delegate :first_name, :last_name, to: :parent, prefix: true

  def pronoun
    case gender
    when 'female'; 'her'
    when 'male'; 'his'
    else
      'their'
    end
  end

  def slug_candidates
    [
      :name,
      [ :name, :parent_first_name ],
      [ :name, :parent_first_name, :parent_last_name ],
      [ :name, :parent_last_name ],
      [ :name, :parent_last_name, :parent_first_name ],
      [ :name, :parent_first_name, :parent_id ],
    ]
  end
end
