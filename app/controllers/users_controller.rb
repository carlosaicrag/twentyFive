class UsersController < ApplicationController
  def index 
    users = User.all

    render json: users
  end

  def show
    # user = User.find(params[:id]) #error loudly: if we do not find the user, then i (the program) will stop running
    user = User.find_by(id: params[:id]) #error softly, this will not stop program if we do not find user

    if user.nil?
      render json: "Sorry user wasn't found"
    else
      render json: user
    end
  end

  def new 
    @user = User.new
    render :new
  end

  def create
    debugger
    @user = User.new(params.require(:user).permit(:username,:email))

    if @user.save
      render json: @user
    else
      render :new
    end
  end

  def edit 

  end

  def update
    user = User.find_by(id: params[:id])
    if user.nil?
      render json: "user not found"
    elsif user.update(user_params)
      render json: user
    else
      render json: "we couldn't update user"
    end
  end

  def delete
    user = User.find_by(id: params[:id])

    user.destroy

    render json: user
  end

  private 

  def user_params
    params.require(:user).permit(:username,:email)
  end
end

