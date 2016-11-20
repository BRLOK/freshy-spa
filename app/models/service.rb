class Service < ApplicationRecord
  VALID_DURATIONS = [15, 30, 60, 90, 120]

  validates :name, presence: true
  validates :duration, presence: true, numericality: { only_integer: true }, inclusion: { in: VALID_DURATIONS }

  scope :active, -> { where(active: true) }
end
