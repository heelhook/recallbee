class DashboardController < ApplicationController
  before_filter :authenticate_user!
  
  layout 'application'
  
  def index
    @child = Child.new
    @new_toy_template = ToyOwnership.new(child_id: '1')

    @show_welcome_box = current_user.children.empty?

    if session[:show_next_steps]
      @show_next_steps = true
      session[:show_next_steps] = nil
    end

    @toy_suggestions = {
      'male' => [
        Toy.search_one('653569874454'),
        Toy.search_one('074299559891'),
        Toy.search_one('673419212502'),
        Toy.search_one('048517805633'),
      ],
      'female' => [
        Toy.search_one('746775222352'),
        Toy.search_one('746775266509'),
        Toy.search_one('653569735625'),
        Toy.search_one('813268013893'),
        Toy.search_one('886144910425'),
      ],
    }
  end

  def payments
  end
end
