class Search < ActiveRecord::Base

	has_many :terms
	accepts_nested_attributes_for :terms
	belongs_to :user
	default_scope { order ('created_at DESC')}
end
