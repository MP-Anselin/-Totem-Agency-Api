class BasicTestsController < ApplicationController
  before_action :set_basic_test, only: [:show, :update, :destroy]

  # GET /basic_tests
  def index
    @basic_tests = BasicTest.all

    render json: @basic_tests
  end

  # GET /basic_tests/1
  def show
    render json: @basic_test
  end

  # POST /basic_tests
  def create
    @basic_test = BasicTest.new(basic_test_params)

    if @basic_test.save
      render json: @basic_test, status: :created, location: @basic_test
    else
      render json: @basic_test.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /basic_tests/1
  def update
    if @basic_test.update(basic_test_params)
      render json: @basic_test
    else
      render json: @basic_test.errors, status: :unprocessable_entity
    end
  end

  # DELETE /basic_tests/1
  def destroy
    @basic_test.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_basic_test
      @basic_test = BasicTest.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def basic_test_params
      params.require(:basic_test).permit(:name, :description)
    end
end
