class SearchesController < ApplicationController
  require 'rubygems'
	require 'twitter'
  before_action :twitter_init
  respond_to :json, :html

  def index
    # @searches = Search.all
    # respond_with @searches
    @search = Search.new
    2.times { @search.terms.build }

    if params[:search_id]
      @s = Search.find(params[:search_id])
      get_tweets(@s)
    end
  end

  def new
    @search = Search.new
  end

  def create

    @search = Search.new(search_params)

    if @search.save
      respond_to do |format|
        format.html {redirect_to searches_path(search_id: @search.id)}
        format.json do 
          render json: { term1: @search.terms.first, term2: @search.terms.last }, status: :created
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
      config.consumer_key        = "ZVIgrKzFHV0s7MkUPsUaRxSB0"
      config.consumer_secret     = "8ZvyhbwenIBiiDZX2V5jbfCyClvliVX08nBmKCJWs8JthZDapL"
      config.access_token        = "30171655-TFN84aT0l0qqI5BgxCCko9Ueg2iHNCOlFPQhmBiw2"
      config.access_token_secret = "nGsiCp8tgYZ90CbDSfDjgB4ytCnF9GqXbb40XLetkGPpi"
    end
  end

  def search_params
    params.require(:search).permit(:terms_attributes => [:text])
  end

  def get_tweets(search)
    if search.terms
      @tweets = @twitter.search(search.terms[0].text, result_type: "recent").take(100)
    else
      @tweets = @twitter.search("geo", result_type: "recent").take(100)
    end

    if search.terms[1]
      @tweets2 = @twitter.search(search.terms[1].text, result_type: "recent").take(100)
    else
      @tweets2 = @twitter.search("geo", result_type: "recent").take(100)
    end
  end


end