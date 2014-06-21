class FiltersController < ApplicationController
  respond_to :html, :json
  
  def index
    @filters = Filter.query()
    
    unless @filters.blank?
      session[:filter_id] ||= @filters.first.id
      @cases = Case.query(session[:filter_id])
    end
  end
  
  def show
    @cases = Case.query(params[:id])
    session[:filter_id] = params[:id]
    
    respond_with @cases
  end
end