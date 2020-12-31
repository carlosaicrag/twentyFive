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

  def create
    debugger
    user = User.new(params.require(:user).permit(:username,:email))

  end

  private 

  def user_params
    params.require(:user).permit(:username,:email)
  end
end

