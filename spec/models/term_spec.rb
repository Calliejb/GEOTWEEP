require 'spec_helper'

describe Term do
  	it "is valid with a search term" do
		search1 = Term.new(text: "geo")
		expect(search1).to be_valid
	end

	it "is not valid without a search term" do
		search1 = Term.new(text: nil)
		expect(search1).to be_invalid
	end

	it { should belong_to(:search) }
	it { should have_db_column(:text) }
	it { should have_db_column(:search_id) }
end
