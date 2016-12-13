class User < ApplicationRecord
  class MustHaveOneActive < StandardError; end;
  after_save :ensure_one_active, on: :update

  has_and_belongs_to_many :services
  has_many :attendances

  VALID_ROLES = ["admin", "operator", "collaborator"]

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: /.+@.+\..+/i }
  has_secure_password
  validates :role, presence: true, inclusion: { in: VALID_ROLES }
  has_secure_token :auth_token

  scope :active,        -> { where(active: true) }
  scope :collaborators, -> { where(role: "collaborator") }

  VALID_ROLES.each do |some_role|
    define_method "#{some_role}?" do
      some_role == self.role
    end
  end

  private

  def ensure_one_active
    if User.active.count.zero?
      self.errors.add(:base, "Não é possível desativar todos os usuários")
      raise MustHaveOneActive
    end
  end
end
