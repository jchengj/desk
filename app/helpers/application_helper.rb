module ApplicationHelper
  def current_filter(id)
    session[:filter_id] == id ? "active" : ""
  end
  
  def current_nav(path)
    current_page?(path) ? "active" : ""
  end
end
