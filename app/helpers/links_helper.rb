module LinksHelper
  def today_link
    link_to(I18n.l(Date.current, format: :long), root_path, class: "btn btn-default")
  end

  def dashboard_link
    link_to dashboard_index_path, class: "btn btn-sm btn-info" do
      "<span class='glyphicon glyphicon-calendar'></span>Calendário".html_safe
    end
  end

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
end
