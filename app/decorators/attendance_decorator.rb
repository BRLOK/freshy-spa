class AttendanceDecorator < Draper::Decorator
  delegate_all

  def status
    I18n.t "enums.attendance.status.#{object.status}"
  end

  def scheduled_for
    I18n.l object.scheduled_for, format: :long
  end

  def customer_name
    object.customer.name
  end

  def items_text
    text = ""
    object.items.each do |item|
      text += "#{item.service.name} - #{item.collaborator.name}<br/>"
    end
    text.html_safe
  end
end
