class CasesController < ApplicationController
  before_filter :current_user
  
  def index
    @filters = Filter.query()
    @cases = Case.query(@filters.first.id)
  end
end
