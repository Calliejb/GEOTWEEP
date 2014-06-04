class AddTerm3ToSearches < ActiveRecord::Migration
  def change
    add_column :searches, :term3, :string
  end
end
