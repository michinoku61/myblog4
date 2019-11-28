class TweetsController < ApplicationController
  def index
    @tweets = Tweet.all

    # @tweets = Tweet.includes(:user).page(params[:page]).per(5).order("id DESC")
  end

  def new
  end

  def create
    @tweet = Tweet.create(name: tweet_params[:name],text: tweet_params[:text], image: tweet_params[:image])
    redirect_to tweets_path
  end

  private
  def tweet_params
    params.permit(:name, :text, :image)
  end
end
