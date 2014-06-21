class LabelsController < ApplicationController
  respond_to :html, :json
  
  def index
    @labels = Label.query()
    respond_with @labels
  end
  
  def create
    respond_with Label.create(params[:label])
  end
end
