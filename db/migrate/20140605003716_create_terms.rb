class CreateTerms < ActiveRecord::Migration
  def change
    create_table :terms do |t|
      t.string :text
      t.references :search, index: true

      t.timestamps
    end
  end
end
