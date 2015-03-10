class Alert < ActiveRecord::Base
  belongs_to :child
  belongs_to :report, class_name: 'ToyReport'
  has_one :toy, through: :report

  validates :child_id, :report_id, presence: true

  def acknowledged?
    !!acknowledged_on
  end
end
