class FileLocationsController < ApplicationController
  before_filter :authenticate

  def index
    @file_locations = Task.find(params[:task_id]).file_locations
    render json: @file_locations, status: :ok
  end

  def create
    @file_location = Task.find(params[:task_id]).file_locations.new(file_location_params)
    if @file_location.save
      render json: @file_location, status: :created, location: @file_location
    else
      render json: @file_location.errors, status: :unprocessable_entity
    end
  end

  def show
    @file_location = FileLocation.find(params[:id])
    render json: @file_location, status: :ok
  end

  def destroy
    @file_location = FileLocation.find(params[:id])
    @file_location.destroy
    head :no_content
  end

  private

    def file_location_params
      params.require(:file_location).permit(:name, :url)
    end

end
