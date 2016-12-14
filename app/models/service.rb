class Service < ApplicationRecord
  # translated as Tratamento
  has_and_belongs_to_many :users

  VALID_DURATIONS = [30, 60, 90, 120]

  validates :name, presence: true, uniqueness: true
  validates :duration, presence: true, numericality: { only_integer: true }, inclusion: { in: VALID_DURATIONS }

  scope :active,      -> { where(active: true) }
  scope :by_user_id,  -> (user_id) { joins(:users).where("users.id = ?", user_id).uniq }
end
