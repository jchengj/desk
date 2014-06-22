class CasesController < ApplicationController
  def update
    respond_with Case.update(params[:labels])
  end
end