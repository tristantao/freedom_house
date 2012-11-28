class RemoveLocationFromArticle < ActiveRecord::Migration
  def up
    remove_column :articles, :location
  end

  def down
    add_column :articles, :location, :string
  end
end
