class User < ApplicationRecord
  class MustHaveOneActive < StandardError; end;
  after_save :ensure_one_active, on: :update

  VALID_ROLES = ["admin", "operator", "collaborator"]
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: /.+@.+\..+/i }
  has_secure_password
  validates :role, presence: true, inclusion: { in: VALID_ROLES }

  scope :active, -> { where(active: true) }

  private

  def ensure_one_active
    if User.active.count.zero?
      self.errors.add(:base, "Não é possível desativar o último usuário")
      raise MustHaveOneActive
    end
  end
end