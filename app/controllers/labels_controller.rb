class LabelsController < ApplicationController
  
  def index
    @labels = Label.query()
  end
end
