class User < ApplicationRecord
  after_save(on: :update) do
    if User.active.count.zero?
      raise "Não é possível desativar o último usuário"
    end
  end

  VALID_ROLES = ["admin", "operator", "collaborator"]
  validates :name, presence: true
  validates :role, presence: true, inclusion: { in: VALID_ROLES }
  validates :email, presence: true, uniqueness: true
  has_secure_password

  scope :active, -> { where(active: true) }
end
