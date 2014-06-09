class SearchesController < ApplicationController
  require 'rubygems'
	require 'twitter'
  require 'tweetstream'
  before_action :twitter_init
  respond_to :json, :html

  def index

    @search = Search.new
    @search.terms.build

    if params[:search_id]
      @s = Search.find(params[:search_id])
      get_tweets(@s)
    end


    @searches = Search.all
    respond_to do |format|
      format.html
      format.json do
        render json: @searches
      end
    end
  end

  def new
    @search = Search.new
  end

  def create

    @search = Search.new(search_params)
    @search.user = current_user

    if @search.save
      respond_to do |format|
        format.html {redirect_to searches_path(search_id: @search.id)}
        format.json do 
          render json: { terms: @search.terms.map(&:text), tweets1: @tweets, tweets2: @tweets2 }, status: :created
        end
      end
    else
      respond_to do |format|
        format.html {render 'new'}
        format.json {render json: @search.errors, status: :unprocessable_entity}
      end
    end


  end

  def show
    @search = Search.find(params[:id])
    respond_to do |format|
      format.html {render 'show'}
      format.json do 
        get_tweets(@search)
        render json: { terms: @search.terms.map(&:text), tweets1: @tweets, tweets2: @tweets2 }
      end
    end
  end

private

  def twitter_init
    @twitter = Twitter::REST::Client.new do |config|
      config.consumer_key        = "f0GidKtuTEDKhUo9KRv8oTHTn"
      config.consumer_secret     = "Zpto8PZa2DtRJCRwtrrEwk9aluCOkyYN3QY6L2uivUuoPrDiUc"
      config.access_token        = "74282467-2qwuw312kRAGSCuQwtxQx3UAwQswAvbmfjRHU3VAA"
      config.access_token_secret = "dS9MlX9mhNd5AXEKztvTNyQpnUJMcHmdCAHMJ4zpeW9nZ"
    end
  end

  def search_params
    params.require(:search).permit(:terms_attributes => [:text])
  end

  def get_tweets(search)

    if search.terms[0]
      @tweets = @twitter.search(search.terms[0].text, :result_type => "recent").take(100)      
      10.times do
        last_id = @tweets.last.id - 1
        @tweets = @tweets + @twitter.search(search.terms[0].text, max_id: last_id, result_type: "recent").take(100)
      end
    else
      @tweets = nil
    end

    if search.terms[1]
      @tweets2 = @twitter.search(search.terms[1].text, result_type: "recent").take(100)  
      10.times do
        last_id = @tweets2.last.id - 1
        @tweets2 = @tweets2 + @twitter.search(search.terms[1].text, max_id: last_id, result_type: "recent").take(100)
      end
    else
      @tweets2 = nil
    end

    if search.terms[2]
      @tweets3 = @twitter.search(search.terms[2].text, result_type: "recent").take(100)  
      10.times do
        last_id = @tweets3.last.id - 1
        @tweets3 = @tweets3 + @twitter.search(search.terms[1].text, max_id: last_id, result_type: "recent").take(100)
      end
    else
      @tweets3 = nil
    end


  end


end
