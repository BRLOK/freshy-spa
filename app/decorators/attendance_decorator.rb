class AttendanceDecorator < Draper::Decorator
  delegate_all
  decorates :attendance

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

  def items_text
    text = ""
    attendance.items.each do |item|
      text += "#{item.service.name} - #{item.collaborator.name}<br/>"
    end
    text.html_safe
  end
end
