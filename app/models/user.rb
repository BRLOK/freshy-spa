class User < ApplicationRecord
  VALID_ROLES = ["admin", "operator", "collaborator"]
  validates :name, presence: true
  validates :role, presence: true, inclusion: { in: VALID_ROLES }
  validates :email, presence: true, uniqueness: true
  has_secure_password
end
