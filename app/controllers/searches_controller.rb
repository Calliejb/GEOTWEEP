class SearchesController < ApplicationController
	require 'rubygems'
	require 'twitter'
  def index
  	@searches = Search.all
    # respond_to do |format|
    #   format.html
    #   format.json {render json: @searches }
    # end

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
      @tweets = twitter.search("geo", result_type: "recent").take(100)
    end

    # if params.has_key?(:term2) && params[:term2] != ""
    #   @tweets = twitter.search(params[:term2], result_type: "recent").take(500)
    # else
    #   @tweets = twitter.search("geo", result_type: "recent").take(100)
    # end
  end

  def new
    @search = Search.new
  end

  def create
    @search = Search.new(params.require(:search).permit(:term))
    if @search.save
      respond_to do |format|
        format.html {redirect_to searches_path}
        format.json {render json: @search, status: :created}
      end
    else
      respond_to do |format|
        format.html {render 'new'}
        format.json {render json: @search.errors, status: :unprocessable_entity}
      end
    end
  end

  def show
  end

end