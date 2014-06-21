class CasesController < ApplicationController
  respond_with :json
  
  def update
    respond_with Case.update(params[:labels])
  end
end