module ApplicationHelper
  def classes_for_scoped_css
    classes = []
    classes << "#{params[:controller].parameterize('-')}-controller"
    classes << "#{params[:action].parameterize('-')}-action"
    classes.join(" ").gsub("_", "-")
  end

  def active_class(params, match_string)
    params[:controller].match(match_string).present? ? "active" : ""
  end
end
