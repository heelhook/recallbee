class TestResourcesController < ApplicationController
  before_action :set_test_resource, only: [:show, :edit, :update, :destroy]

  # GET /test_resources
  # GET /test_resources.json
  def index
    @test_resources = TestResource.all
  end

  # GET /test_resources/1
  # GET /test_resources/1.json
  def show
  end

  # GET /test_resources/new
  def new
    @test_resource = TestResource.new
  end

  # GET /test_resources/1/edit
  def edit
  end

  # POST /test_resources
  # POST /test_resources.json
  def create
    @test_resource = TestResource.new(test_resource_params)

    respond_to do |format|
      if @test_resource.save
        format.html { redirect_to @test_resource, notice: 'Test resource was successfully created.' }
        format.json { render :show, status: :created, location: @test_resource }
      else
        format.html { render :new }
        format.json { render json: @test_resource.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /test_resources/1
  # PATCH/PUT /test_resources/1.json
  def update
    respond_to do |format|
      if @test_resource.update(test_resource_params)
        format.html { redirect_to @test_resource, notice: 'Test resource was successfully updated.' }
        format.json { render :show, status: :ok, location: @test_resource }
      else
        format.html { render :edit }
        format.json { render json: @test_resource.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /test_resources/1
  # DELETE /test_resources/1.json
  def destroy
    @test_resource.destroy
    respond_to do |format|
      format.html { redirect_to test_resources_url, notice: 'Test resource was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_test_resource
      @test_resource = TestResource.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def test_resource_params
      params.require(:test_resource).permit(:name)
    end
end
