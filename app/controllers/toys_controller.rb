class ToysController < ApplicationController
  before_filter :load_resources, except: [:search]

  def index
    @toys = @child.toys
  end

  def create
    params[:toys].each do |toy_id, boolean|
      if boolean == 'true'
        toy_ownership = @child.toy_ownerships.new(
          toy_id: toy_id,
        )

        authorize toy_ownership
        toy_ownership.save!
      end
    end

    head :no_content
  end

  def search
    @toys = ToySearchService.search(params[:q], 'Toys')

    render json: @toys
  end

  private

  def load_resources
    @child = Child.where(slug: params[:child_id]).first!
  end
end
