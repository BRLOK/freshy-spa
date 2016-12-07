class Customer < ApplicationRecord
  validates :name, presence: true
  validates :email, uniqueness: true, format: { with: /.+@.+\..+/i }, allow_blank: true
  validates :cpf, uniqueness: true, cpf: true, allow_blank: true
  validates :telephone, presence: true

  scope :active, -> { where(active: true) }
end