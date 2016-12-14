class UserDecorator < Draper::Decorator
  class PaginatingDecorator < Draper::CollectionDecorator
    delegate :current_page, :per_page, :offset, :total_entries, :total_pages
  end
  delegate_all

  def self.collection_decorator_class
    PaginatingDecorator
  end

  def role
    I18n.t "enums.user.role.#{object.role}"
  end

  def active
    I18n.t object.active.to_s
  end

  def services
    if object.services.present?
      object.services.pluck(:name).join(", ")
    else
      "-"
    end
  end
end
