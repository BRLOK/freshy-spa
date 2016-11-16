class User < ApplicationRecord
  after_save :ensure_one_active, on: :update

  VALID_ROLES = ["admin", "operator", "collaborator"]
  validates :name, presence: true
  validates :role, presence: true, inclusion: { in: VALID_ROLES }
  validates :email, presence: true, uniqueness: true
  has_secure_password

  scope :active, -> { where(active: true) }

  private

  def ensure_one_active
    raise "Não é possível desativar o último usuário" if User.active.count.zero?
  end
end
