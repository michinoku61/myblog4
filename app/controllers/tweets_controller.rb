class TweetsController < ApplicationController
  before_action :login_check, except: [:top, :index]
  before_action :current_user_name
  def top
  end

  def index
    @tweets = Tweet.includes(:user).page(params[:page]).per(5).order("id DESC")
  end

  def new
    redirect_to action: :index unless user_signed_in?
  end

  def show
    @tweet = Tweet.includes(:user).find(params[:id])
    @like = Like.new
  end

  def create
    @tweet = Tweet.create(name: tweet_params[:name],text: tweet_params[:text], image: tweet_params[:image],  user_id: current_user.id)
    redirect_to tweets_path
  end

  def destroy
    tweet = Tweet.find(params[:id])
    if tweet.user_id == current_user.id
      tweet.destroy
    end
    redirect_to action: :index
  end

  private
  def tweet_params
    params.permit(:name, :text, :image)
  end

  def login_check
    redirect_to "/users/sign_in" unless user_signed_in?
  end
  
  def current_user_name
    if User.ids != nil && user_signed_in?
      @current = User.find(current_user.id)
    end
  end
end
