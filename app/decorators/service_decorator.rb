class ServiceDecorator < Draper::Decorator
  class PaginatingDecorator < Draper::CollectionDecorator
    delegate :current_page, :per_page, :offset, :total_entries, :total_pages
  end
  delegate_all

  def self.collection_decorator_class
    PaginatingDecorator
  end

  def description
    if object.description.present?
      object.description
    else
      '-'
    end
  end

  def short_description
    if description.length > 60
      description.truncate(60, separator: ' ')
    else
      description
    end
  end

  def active
    I18n.t object.active.to_s
  end
end
