class AttendanceItem < ApplicationRecord
  belongs_to :attendance
  belongs_to :service
  belongs_to :collaborator, class_name: User

  scope :pending,         -> { where("started_at IS NULL") }
  scope :in_progress,     -> { where("started_at IS NOT NULL && finished_at IS NULL") }
  scope :finished,        -> { where("started_at IS NOT NULL && finished_at IS NOT NULL") }
  scope :by_collaborator, -> (collaborator) { where(user_id: collaborator.id) }
end
