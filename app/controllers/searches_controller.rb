class SearchesController < ApplicationController
	require 'rubygems'
	require 'twitter'
  def index
  	@searches = Search.all

    def new
      @search = Search.new
    end

    twitter = Twitter::REST::Client.new do |config|
      config.consumer_key        = "ZVIgrKzFHV0s7MkUPsUaRxSB0"
      config.consumer_secret     = "8ZvyhbwenIBiiDZX2V5jbfCyClvliVX08nBmKCJWs8JthZDapL"
      config.access_token        = "30171655-TFN84aT0l0qqI5BgxCCko9Ueg2iHNCOlFPQhmBiw2"
      config.access_token_secret = "nGsiCp8tgYZ90CbDSfDjgB4ytCnF9GqXbb40XLetkGPpi"
    end

    if params.has_key?(:term) && params[:term] != ""
      @tweets = twitter.search(params[:term], result_type: "recent").take(500)
    else
      @tweets = twitter.search("geo", result_type: "recent").take(10)
    end

    
    twitter.search(:term, result_type: "recent").take(5).each do |tweet|
      @twt = tweet.text
    end

  end

  def create
    @search = Search.new(params.require(:search).permit(:term))
    if @search.save
      redirect_to searches_path
    else
      render :new
    end
  end

  def show
  end
end