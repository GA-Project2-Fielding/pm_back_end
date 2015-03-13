class TasksController < ApplicationController
  before_filter :authenticate

  def index
    @tasks = Project.find(params[:project_id]).tasks
    render json: @tasks, status: :ok
  end

  def show
    @task = Task.find(params[:id])
    render json: @task, status: :ok
  end

  def create
    @task = Project.find(params[:project_id]).tasks.new(task_params)
    if @task.save
      render json: @task, status: :created, location: @task
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      render json: @task, status: :ok
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    head :no_content
  end

  private
    def task_params
      params.require(:task).permit(:due_date, :completed, :priority, :title, :description)
    end
end
