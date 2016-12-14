class AttendanceItemDecorator < Draper::Decorator
  delegate_all
  decorates :attendance_item

  def started_at
    if attendance_item.started_at.present?
      I18n.l attendance_item.started_at, format: :long
    end
  end

  def finished_at
    if attendance_item.finished_at.present?
      I18n.l attendance_item.finished_at, format: :long
    end
  end

  def service_name
    attendance_item.service.name
  end

  def duration
    "#{attendance_item.service.duration} minutos"
  end
end
