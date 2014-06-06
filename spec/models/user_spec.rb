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

end

describe "Sign-In Page" do
	describe "with valid sign-in information" do
		before { sign_in(:user) } 

		it { should have_selector('a', text: 'Sign up')}
        it { should have_selector('a', text: 'Sign in')}
        it { should have_selector('a', text: 'Sign Out') }
	end
end
