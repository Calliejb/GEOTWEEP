class Term < ActiveRecord::Base
	validates_presence_of :text
	belongs_to :search
end
