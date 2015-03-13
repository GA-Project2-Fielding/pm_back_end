class CommentsController < ApplicationController
  # before_filter :authenticate

  def index
    @comments = Task.find(params[:task_id]).comments
    render json: @comments, status: :ok
  end

  def show
    @comment = Comment.find(params[:id])
    render json: @comment, status: :ok
  end

  def create
    @comment = Task.find(params[:task_id]).comments.new(comment_params)
    if @comment.save(comment_params)
      render json: @comment, status: :created, location: @comment
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.update(comment_params)
      render json: @comment, status: :ok
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @comment = Comment.find(params[id])
    @comment.destroy
    head :no_content
  end

  private
    def comment_params
      params.require(:comment).permit(:body)
    end
end
