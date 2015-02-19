class SiteController < ApplicationController
  layout 'landing'

  def index
    @header_ab_test = ab_test('header',
      "Alerts when your kids’ toys become safety hazards",
      "Free alerts when your kids’ toys become safety hazards"
    )
  end

  def about
  end

  def how_it_works
    if current_user
      @child = current_user.children.try(:first) || Child.new
      @email = current_user.email
    else
      @child = Child.new(name: session[:child_name])
      @email = session[:email]
    end

    @child.toys = [
      Toy.new(name: 'Toy 1'),
    ]

    @skip_footer = true
  end
end
