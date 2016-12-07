class AttendanceItem < ApplicationRecord
  belongs_to :attendance
  belongs_to :services
  belongs_to :users, as: :collaborators

  scope :pending,     -> { where("started_at IS NULL") }
  scope :in_progress, -> { where("started_at IS NOT NULL && finished_at IS NULL") }
  scope :finished,    -> { where("started_at IS NOT NULL && finished_at IS NOT NULL") }
end
