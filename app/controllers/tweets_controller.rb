class TweetsController < ApplicationController
  before_action :login_check, except: [:index, :show, :top]
  def top
  end

  def index
    @tweets = Tweet.includes(:user).page(params[:page]).per(5).order("id DESC")

    # @tweets = Tweet.includes(:user).page(params[:page]).per(5).order("id DESC")
  end

  def new
    redirect_to action: :index unless user_signed_in?
    @tweet = Tweet.find(current_user.id)
  end

  def show
    @tweet = Tweet.includes(:user).find(params[:id])
  end

  def create
    @tweet = Tweet.create(name: tweet_params[:name],text: tweet_params[:text], image: tweet_params[:image],  user_id: current_user.id)
    redirect_to tweets_path
  end

  private
  def tweet_params
    params.permit(:name, :text, :image)
  end

  def login_check
    redirect_to "/users/sign_in" unless user_signed_in?
  end
end
