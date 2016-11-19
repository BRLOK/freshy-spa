class ApplicationRecord < ActiveRecord::Base
  class MustHaveOneActive < StandardError; end;
  after_save :ensure_one_active, on: :update

  self.abstract_class = true

  private

  def ensure_one_active
    if User.active.count.zero?
      self.errors.add(:base, "Não é possível desativar todos")
      raise MustHaveOneActive
    end
  end
end
