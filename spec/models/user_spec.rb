require 'spec_helper'

describe User do

	it "has a valid factory" do
		expect(FactoryGirl.build(:user)).to be_valid
	end

	it "is invalid without an email" do
		noemail = FactoryGirl.build(:user, email: nil)
		expect(noemail).to be_invalid
	end

	it "is invalid without a password" do
		passwordless = FactoryGirl.build(:user, password: nil)
		expect(passwordless).to be_invalid
	end

	it { should ensure_length_of(:password).is_at_least(6) }
	it { should have_many(:searches) }
	it { should have_db_column(:username) }
	it { should have_db_column(:email) }
end

