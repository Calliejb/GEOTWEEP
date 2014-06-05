class Search < ActiveRecord::Base
	# validates_presence_of :term
	has_many :terms
	accepts_nested_attributes_for :terms
end
