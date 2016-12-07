class Attendance < ApplicationRecord
  belongs_to :customer
  has_many :attendance_items, as: :items
  has_many :services, through: :attendance_items
  has_many :users, through: :attendance_items, as: :collaborators

  VALID_STATUS = ["scheduled", "in_progress", "finished", "expired"]

  validates :scheduled_for, presence: true
  validates :status, presence: true, inclusion: { in: VALID_STATUS }

  scope :scheduled_for,         -> (date) { where(scheduled_for: date) }
  scope :scheduled_for_before,  -> (date) { where("scheduled_for >= ?", date) }
  scope :scheduled_for_after,   -> (date) { where("scheduled_for <= ?", date) }

  VALID_STATUS.each do |some_status|
    define_method "#{some_status}?" do
      some_status == self.status
    end
  end
end
