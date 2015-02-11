class DashboardController < ApplicationController
  before_filter :authenticate_user!
  
  layout 'application'
  
  def index
    @child = Child.new
    @toy = Toy.new

    @show_welcome_box = current_user.children.empty?
  end
end
