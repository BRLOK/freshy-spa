class AttendanceDecorator < Draper::Decorator
  delegate_all
  decorates :attendance

  def status
    I18n.t "enums.attendance.status.#{attendance.status}"
  end

  def scheduled_for
    I18n.l attendance.scheduled_for, format: :long
  end

  def customer_name
    attendance.customer.name
  end

  def customer_link
    h.link_to customer_name, attendance.customer
  end

  def items_text
    text = ""
    attendance.items.each do |item|
      text += "#{item.service.name} - #{item.collaborator.name}<br/>"
    end
    text.html_safe
  end

  def show_link
    h.link_to attendance, class: "btn btn-sm btn-primary" do
      "<span class='glyphicon glyphicon-eye-open'></span>Ver".html_safe
    end
  end

  def edit_link
    h.link_to h.edit_attendance_path(attendance), class: "btn btn-sm btn-warning" do
      "<span class='glyphicon glyphicon-pencil'></span>Editar".html_safe
    end
  end
end
