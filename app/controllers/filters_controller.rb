class FiltersController < ApplicationController
  
  def index
    @filters = Filter.query()
    @labels = Label.query()
    
    unless @filters.blank?
      session[:filter_id] ||= @filters.first.id
      @cases = Case.query(session[:filter_id])
    end
  end
  
  def show
    @cases = Case.query(params[:id])
    @labels = Label.query()
    session[:filter_id] = params[:id]
    
    render :partial => "cases" and return
  end
end