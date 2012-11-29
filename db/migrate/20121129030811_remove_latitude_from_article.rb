class RemoveLatitudeFromArticle < ActiveRecord::Migration
  def up
    remove_column :articles, :latitude
    remove_column :articles, :longitude
  end

  def down
    add_column :articles, :latitude, :float
    add_column :articles, :longitude, :float
  end
end
