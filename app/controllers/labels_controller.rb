class LabelsController < ApplicationController
  
  def index
    @labels = Label.query()
  end
  
  def create
    Label.create(params.select {|k,v| Label::PARAM.include? k})
    redirect_to labels_path, :notice => "Label created successfully"
  end
end
