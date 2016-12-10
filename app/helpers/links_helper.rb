module LinksHelper
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
