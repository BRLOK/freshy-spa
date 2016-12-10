class Attendance < ApplicationRecord
  belongs_to :customer
  has_many :items, class_name: AttendanceItem
  has_many :services, through: :attendance_items
  has_many :collaborators, through: :attendance_items, class_name: User
  accepts_nested_attributes_for :items

  VALID_STATUS = ["scheduled", "in_progress", "finished", "expired"]

  validates :scheduled_for, presence: true
  validates :status, presence: true, inclusion: { in: VALID_STATUS }

  before_create :set_default_status

  scope :scheduled_for,         -> (date) { where(scheduled_for: date) }
  scope :scheduled_for_before,  -> (date) { where("scheduled_for >= ?", date) }
  scope :scheduled_for_after,   -> (date) { where("scheduled_for <= ?", date) }
  scope :by_collaborator,       -> (collaborator) { joins(:items).merge(AttendanceItem.by_collaborator(collaborator)).uniq }

  VALID_STATUS.each do |some_status|
    define_method "#{some_status}?" do
      some_status == self.status
    end
  end

  def start_time
    self.scheduled_for.to_date
  end


  def set_default_status
    self.status ||= 'scheduled'
  end
end
