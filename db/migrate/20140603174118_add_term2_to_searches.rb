class AddTerm2ToSearches < ActiveRecord::Migration
  def change
    add_column :searches, :term2, :string
  end
end
