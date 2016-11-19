class Service < ApplicationRecord
  validates :name, presence: true
  validates :duration, presence: true, numericality: { only_integer: true }

  scope :active, -> { where(active: true) }
end
