class ProjectsController < ApplicationController
  before_filter :authenticate

  def index
    @projects = User.find(params[:user_id]).projects
    # @projects = @user.projects
    render json: @projects, status: 200
  end

  def show
    @project = Project.find(params[:id])
    render json: @project, status: 200
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      @project.users << User.find(params[:user_id])
      render json: @project, status: :created
    else
      render json: @project.errors, status: :unprocessable_entity
    end
  end

  def update
    @project = Project.find(params[:id])
    if @project.update(project_params)
      render json: @project, status: 200
    else
      render json: @project.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    head :no_content
  end

private

def project_params
  params.require(:project).permit(:project_title, :description, :start_date, :due_date, :completion_date, :completed, :visible)
end

end
