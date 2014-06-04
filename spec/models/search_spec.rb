require 'spec_helper'

describe Search do
	it "is valid with a search term" do
		search1 = Search.new(term: "geo")
		expect(search1).to be_valid
	end

	it "is not valid without a search term" do
		search1 = Search.new(term: nil)
		expect(search1).to be_invalid
	end
end