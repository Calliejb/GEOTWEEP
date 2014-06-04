class Search < ActiveRecord::Base
	validates_presence_of :term
end
