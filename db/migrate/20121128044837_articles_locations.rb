class ArticlesLocations < ActiveRecord::Migration
  def up
    create_table :articles_locations, :id => false do |t|
      t.integer :location_id
      t.integer :article_id
    end
  end

  def down
    drop_table :articles_locations
  end
end
