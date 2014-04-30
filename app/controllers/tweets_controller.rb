class TweetsController < ApplicationController
  before_filter :authenticate_user!

  before_action :set_tweet, only: [:show, :edit, :update, :destroy, :send_now]

  def send_now
    sent = tweet_params[:sent] == "true"

    if !@tweet.sent
      @tweet.publish
      notice = "Tweet was Sent!"
    else
      notice = "Oops, you already Tweeted That"
    end

    redirect_to @tweet, notice: notice
  end

  # GET /tweets
  def index
    # @tweets = Tweet.all.order(send_at: :asc)
    @tweets = Tweet.hwk_tweets #.order(send_at: :asc)
    @personal_tweets = current_user.my_tweets #.order(send_at: :asc)
    # @tweets = Tweet.where(authentication: current_user.authentications)
  end

  # GET /tweets/1
  def show
  end

  # GET /tweets/new
  def new
    @tweet = Tweet.new
  end

  # GET /tweets/1/edit
  def edit
  end

  # POST /tweets
  def create
    @tweet = Tweet.new(tweet_params)

    puts "SEND AT"
    puts tweet_params

    if @tweet.save
      redirect_to @tweet, notice: 'Tweet was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /tweets/1
  def update
    puts "SEND AT"
    puts tweet_params

    if @tweet.update(tweet_params)
      redirect_to @tweet, notice: 'Tweet was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /tweets/1
  def destroy
    @tweet.destroy
    redirect_to tweets_url, notice: 'Tweet was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tweet
      @tweet = Tweet.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def tweet_params
      params.require(:tweet).permit(:authentication_id, :body, :sent, :send_at)
    end
end
