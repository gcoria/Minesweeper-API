class UsersController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, :with => :not_found

  def index
    @users = User.all
    render :index, status: :ok, formats: :json
  end

  def show
  	@user = User.find(params[:id])
    render :show, formats: :json, status: :ok
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user, status: :created
    else
      render json: { errors: @user.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  private  	

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
