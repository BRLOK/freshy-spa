class AttendanceDecorator < Draper::Decorator
  delegate_all

  def status
    I18n.t "enums.attendance.status.#{object.status}"
  end

  def scheduled_for
    I18n.l object.scheduled_for
  end

  def customer_name
    object.customer.name
  end
end
