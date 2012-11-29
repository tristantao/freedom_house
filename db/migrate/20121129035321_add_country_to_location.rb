class AddCountryToLocation < ActiveRecord::Migration
  def up
    add_column :locations, :country, :string
  end

  def down
    remove_column :locations, :country, :string
  end
end
