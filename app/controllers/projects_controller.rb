class ProjectsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @projects = @user.projects
    render json: @projects, status: 200
  end

  def show
    @project = Project.find(params[:id])
    render json: @project, status: 200
  end


end
