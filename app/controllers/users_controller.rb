class UsersController < ApplicationController

  def sign_in
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      render json: {token: user.token}
    else
      head :unauthorized
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: {token: @user.token}
    else
      render json: {message: 'failed', status: 500}
    end
  end

  def show
    @user = User.find(params[:id])
    render json: @user, status: 200
  end

  def update
    @user = User.find(params[:id])
    if @user.save
      render json: @user, status: 200
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    head :no_content
  end

  private

  def user_params
    params.require(:user).permit(:user_name, :email, :first_name, :last_name, :password, :password_confirmation, :image_url, :description, :token)
  end

end