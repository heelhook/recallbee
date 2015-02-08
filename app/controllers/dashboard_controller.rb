class DashboardController < ApplicationController
  layout 'application'
  
  def index
    @child = Child.new
  end
end
