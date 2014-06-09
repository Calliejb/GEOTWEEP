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

	it "is invalid without a username" do
		nameless = FactoryGirl.build(:user, username: nil)
		expect(nameless).to be_invalid
	end

	it { should ensure_length_of(:password).is_at_least(6) }
	it { should have_many(:searches) }
	it { should have_db_column(:username) }
	it { should have_db_column(:email) }
end

describe "Sign-In Page" do
	describe "with valid sign-in information" do
		before { sign_in(:user) } 

		it { should have_selector('a', text: 'Sign up')}
        it { should have_selector('a', text: 'Sign in')}
        it { should have_selector('a', text: 'Sign Out') }
	end
end
