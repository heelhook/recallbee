class SiteController < ApplicationController
  layout 'landing'

  def index
    @header_ab_test = ab_test('header',
      "Alerts when your kids’ toys become safety hazards",
      "Free alerts when your kids’ toys become safety hazards"
    )

    @hero_signup_buttons_in_same_line = ab_test('hero signup buttons in same line', 'true', 'false')
  end

  def about
  end

  def how_it_works
  end
end
