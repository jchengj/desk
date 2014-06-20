class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def current_user
    @current ||= User.current_user
  end
end
