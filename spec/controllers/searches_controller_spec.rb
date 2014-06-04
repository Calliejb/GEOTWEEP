require 'spec_helper'

describe SearchesController do
	let :valid_search do
		{
			term: "geo"
		}
	end
	
	describe "GET index" do
		before do 
			@search1 = Search.create! valid_search
			get :index
		end

		it "should render the index template" do
			expect(response).to render_template :index
		end

		it "should succeed" do 
			expect(response).to be_success
		end
	end

	describe "GET new" do
		before do
			get :new
		end

		it "should render the new template" do
			expect(response).to render_template :new
		end

		it "should succeed" do
			expect(response).to be_success
		end

		it "should assign a new search" do
			expect(assigns(:search)).to be_a(Search)
		end
	end

	describe "POST create" do
		describe "successful create" do
			it "should save a new search to the database" do
				expect do
					post :create, search: valid_search
				end.to change(Search, :count).by(1)
			end

			it "should redirect to the index" do
				post :create, search: valid_search
				expect(response).to redirect_to searches_path
			end
		end

		describe "unsuccessful save" do
			let :invalid_search do
				{
					term: nil
				}
			end

			it "should not save a new search to the database" do
				expect do
					post :create, search: invalid_search
				end.to_not change(Search, :count).by(1)
			end

			it "should rerender the new template" do
				post :create, search: invalid_search
				expect(response).to render_template :new
			end
		end
	end

end