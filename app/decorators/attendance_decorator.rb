class AttendanceDecorator < Draper::Decorator
  class PaginatingDecorator < Draper::CollectionDecorator
    delegate :current_page, :per_page, :offset, :total_entries, :total_pages
  end
  delegate_all
  decorates :attendance

  def self.collection_decorator_class
    PaginatingDecorator
  end

  def status
    I18n.t "enums.attendance.status.#{attendance.status}"
  end

  def scheduled_for
    I18n.l attendance.scheduled_for, format: :long
  end

  def scheduled_for_time
    attendance.scheduled_for.to_s(:time)
  end

  def customer_name
    attendance.customer.name
  end

  def customer_first_name
    attendance.customer.name.split(" ").first
  end

  def collaborator_name
    attendance.collaborator.name
  end

  def collaborator_abrv
    names = attendance.collaborator.name.split(" ")
    first_name = names.shift

    [
      first_name,
      names.map{ |str|
        str.first + "." unless ["e", "da", "de", "dos"].include?(str.downcase)
      }
    ].flatten.join(" ")
  end

  def items_text
    attendance.services.pluck(:name).join(', ')
  end
end
