class SiteController < ApplicationController
  layout 'landing'

  def index
    @header_ab_test = ab_test('header',
      "Alerts when your kids’ toys become safety hazards",
      "Free alerts when your kids’ toys become safety hazards"
    )
  end
end
