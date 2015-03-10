class ToyOwnership < ActiveRecord::Base
  belongs_to :toy
  belongs_to :child

  sync :all
  sync_scope :by_child, -> (child) { where(child_id: child.id) }

  delegate :parent_id, to: :child, prefix: false

  after_commit :create_alerts

  def create_alerts
    if toy.reports.any?
      toy.reports.each do |report|
        child.alerts.create!(
          report: report,
        )
      end
    end
  end
end
