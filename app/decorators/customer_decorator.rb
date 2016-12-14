class CustomerDecorator < Draper::Decorator
  class PaginatingDecorator < Draper::CollectionDecorator
    delegate :current_page, :per_page, :offset, :total_entries, :total_pages
  end
  delegate :current_page, :per_page, :offset, :total_entries, :total_pages
  delegate_all

  def self.collection_decorator_class
    PaginatingDecorator
  end

  def email
    if object.email.present?
      object.email
    else
      "-"
    end
  end

  def cpf
    if object.cpf.present?
      object.cpf.insert(9, '-').insert(6, '.').insert(3, '.')
    else
      "-"
    end
  end

  def telephone
    if object.telephone.present?
      object.telephone
    else
      "-"
    end
  end

  def active
    I18n.t object.active.to_s
  end
end
