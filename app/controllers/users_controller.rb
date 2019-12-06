class UsersController < ApplicationController
  before_action :current_user_name
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @tweets = @user.tweets.page(params[:page]).per(5).order("created_at DESC")
  end
  private
  def current_user_name
    @current = User.find(current_user.id)
  end
end
