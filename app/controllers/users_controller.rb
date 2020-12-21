class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @histories = BrowsingHistory.where(user_id: params[:id])
  end

  def index
    @users = User.all
  end

  private
  def user_params
    params.require(:user).permit(:name)
  end
end
