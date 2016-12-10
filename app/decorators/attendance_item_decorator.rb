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

  def collaborator_name
    attendance_item.collaborator.name
  end

  def collaborator_link
    h.link_to collaborator_name, attendance_item.collaborator.name
  end

  def service_name
    attendance_item.service.name
  end

  def service_link
    h.link_to service_name, attendance_item.service.name
  end
end
