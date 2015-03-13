class FilesController < ApplicationController
  before_filter :authenticate

  def index
    @files = Task.find(params[:task_id]).files
    render json: @files, status: :ok
  end

  def create
    @file = Task.find(params[:task_id]).files.new(file_params)
    if @file.save
      render json: @file, status: :created, location: @file
    else
      render json: @file.errors, status: :unprocessable_entity
    end
  end

  def show
    @file = File.find(params[:id])
    render json: @file, status: :ok
  end

  def destroy
    @file = File.find(params[:id])
    @file.destroy
    head :no_content
  end

  private

    def file_params
      params.require(:file).permit(:name, :url)
    end

end
