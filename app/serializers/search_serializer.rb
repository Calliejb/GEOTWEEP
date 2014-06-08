class SearchSerializer < ActiveModel::Serializer
  attributes :id
  has_many :terms
end
