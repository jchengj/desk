class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user
  rescue_from "ApiError", with: :show_error
  
  def current_user
    @current ||= User.current_user
  end
  
  private
  
  def show_error(exception)
    respond_to do |f|
      format.html { redirect_to "/", :error => exception.message }
      format.js { json: {message: exception.message}.to_json, status: 400 }
    end
  end
end
