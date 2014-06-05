class AddSearchesToUsers < ActiveRecord::Migration
  def change
    add_reference :users, :search, index: true
  end
end
