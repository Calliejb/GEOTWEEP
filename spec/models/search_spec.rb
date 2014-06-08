require 'spec_helper'

describe Search do
	it { should belong_to(:user) }
	it { should have_many(:terms) }
	it { should accept_nested_attributes_for(:terms) }
	it { should have_db_column(:user_id) }
end