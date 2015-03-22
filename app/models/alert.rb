class Alert < ActiveRecord::Base
  belongs_to :child
  belongs_to :report, class_name: 'ToyReport'
  has_one :toy, through: :report

  validates :child_id, :report_id, presence: true

  delegate :parent, to: :child

  after_create :send_email

  def acknowledged?
    !!acknowledged_on
  end

  def send_email
  	TransactionMailer.alert(parent, child).deliver
  end
end
