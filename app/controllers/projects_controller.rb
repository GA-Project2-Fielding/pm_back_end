class ProjectsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @projects = @user.projects
    render json: @projects, status: 200
  end


end
