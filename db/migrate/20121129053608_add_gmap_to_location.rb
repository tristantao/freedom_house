class AddGmapToLocation < ActiveRecord::Migration
  def change
    add_column :locations, :gmap, :boolean
  end
end
