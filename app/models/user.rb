class User < ApplicationRecord
  VALID_ROLES = ["admin", "operator", "collaborator"]
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: /.+@.+\..+/i }
  has_secure_password
  validates :role, presence: true, inclusion: { in: VALID_ROLES }

  scope :active, -> { where(active: true) }
end
