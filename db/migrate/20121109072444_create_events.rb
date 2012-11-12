class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.string :description
      t.datetime :date

      t.float :longitude
      t.float :latitude
      t.string :country
      t.string :province
      t.string :city

      t.timestamps
    end
  end
end
