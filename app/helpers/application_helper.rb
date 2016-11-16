module ApplicationHelper
  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end

  def classes_for_scoped_css
    classes = []
    classes << "#{params[:controller].parameterize}-controller"
    classes << "#{params[:action].parameterize}-action"
    classes.join(" ").gsub("_", "-")
  end

  def active_class(params, match_string)
    params[:controller].match(match_string).present? ? "active" : ""
  end

  def class_for_alert(status)
    case status.to_sym
    when :alert, :error, :danger
      "alert-danger"
    when :notice, :success
      "alert-success"
    when :info
      "alert-info"
    when :warning
      "alert-warning"
    end
  end
end
