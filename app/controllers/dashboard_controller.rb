class DashboardController < ApplicationController
  before_filter :authenticate_user!
  
  layout 'application'
  
  def index
    @child = Child.new
    @toy = Toy.new

    @show_welcome_box = current_user.children.empty?

    @toy_suggestions = {
      'male' => [
        Toy.search_one('653569874454'),
        Toy.search_one('074299559891'),
        Toy.search_one('673419212502'),
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
end
