class Customer < ApplicationRecord
  has_many :attendances

  validates :name, presence: true
  validates :email, uniqueness: true, format: { with: /.+@.+\..+/i }, allow_blank: true
  validates :cpf, uniqueness: true, cpf: true, allow_blank: true
  validates :telephone, uniqueness: true, presence: true

  scope :active, -> { where(active: true) }
end
