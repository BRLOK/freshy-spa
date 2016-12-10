module LinksHelper
  # Dashboard Links
  def today_link
    link_to(I18n.l(Date.current, format: :long), root_path, class: "btn btn-default")
  end

  def calendar_link
    link_to dashboard_index_path, class: "btn btn-sm btn-info" do
      "<span class='glyphicon glyphicon-calendar'></span>Calendário".html_safe
    end
  end

  def show_attendance_for_calendar(decorated_attendance)
    link_to decorated_attendance, class: "btn btn-xs #{button_class_for_calendar(decorated_attendance.status)}" do
      "#{decorated_attendance.customer_name} - #{decorated_attendance.scheduled_for_time}"
    end
  end

  def button_class_for_calendar(attendance_status)
    case attendance_status
    when "Agendado"
      "btn-primary"
    when "Em andamento"
      "btn-success"
    when "Terminado"
      "btn-info"
    when "Expirado"
      "btn-danger"
    else
      "btn-default"
    end
  end

  # Attendance Links
  def attendances_link
    link_to attendances_path, class: "btn btn-sm btn-default" do
      "<span class='glyphicon glyphicon-list-alt'></span>Lista".html_safe
    end
  end

  def new_attendance_link
    link_to new_attendance_path, class: "btn btn-sm btn-success" do
      "<span class='glyphicon glyphicon-plus'></span>Novo atendimento".html_safe
    end
  end

  def show_attendance_link(attendance_id)
    link_to attendance_path(attendance_id), class: "btn btn-sm btn-primary" do
      "<span class='glyphicon glyphicon-eye-open'></span>Ver".html_safe
    end
  end

  def edit_attendance_link(attendance_id)
    link_to edit_attendance_path(attendance_id), class: "btn btn-sm btn-warning" do
      "<span class='glyphicon glyphicon-pencil'></span>Editar".html_safe
    end
  end

  # Customer Links
  def show_customer_name_link(customer)
    link_to customer.name, customer
  end

  # Service Links
  def show_service_name_link(service)
    link_to service.name, service
  end

  # User Links
  def show_user_name_link(user)
    link_to user.name, user
  end

  # General Links
  def submit_link
    button_tag type: "submit", class: "btn btn-sm btn-success" do
      "<span class='glyphicon glyphicon-floppy-disk'></span>Salvar".html_safe
    end
  end
end
