class UsersController < ApplicationController
	
	def show
	  @user = User.find(params[:id])
	  @term_count = count_terms
	  @searches = Search.all
	end


  protected

	def count_terms
		terms = Term.all
		terms_array = terms.map { |w| w.text.downcase }
		@num_search = Hash.new(0)
		terms_array.each { |v| @num_search[v] += 1 }
		@num_search.sort_by{ |k, v| -v}
	end


end
