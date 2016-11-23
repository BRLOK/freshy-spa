class Customer < ApplicationRecord
  validates :name, presence: true
  validates :email, uniqueness: true, format: { with: /.+@.+\..+/i }, allow_blank: true
  validates :cpf, uniqueness: true, format: { with: /\A\d{3}\.\d{3}\.\d{3}-\d{2}\z/ }, length: { is: 14 }, allow_blank: true
  validates :telephone, presence: true, format: { with: /\A\(\d{2}\) \d{4,5}-\d{4}\z/ }, length: { minimum: 14 }, allow_blank: true

  scope :active, -> { where(active: true) }
end
