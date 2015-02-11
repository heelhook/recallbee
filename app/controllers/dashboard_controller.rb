class DashboardController < ApplicationController
  layout 'application'
  
  def index
    @child = Child.new
    @toy = Toy.new

    @show_welcome_box = current_user.children.empty?
  end
end
