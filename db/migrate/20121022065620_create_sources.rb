class CreateSources < ActiveRecord::Migration
  def change
    create_table :sources do |t|
      t.string :name
      t.string :home_page
      t.string :url
      t.integer :quality_rating

      t.timestamps
    end
  end
end
