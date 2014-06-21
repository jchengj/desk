module ApplicationHelper
  def current_filter(id)
    session[:filter_id] == id ? "active" : ""
  end
  
  def current_nav(controller, action)
    current_page?(controller, action) ? "active" : ""
  end
end
