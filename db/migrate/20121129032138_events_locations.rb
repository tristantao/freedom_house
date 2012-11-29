class EventsLocations < ActiveRecord::Migration
  def up
    create_table :events_locations, :id => false do |t|
      t.integer :location_id
      t.integer :event_id
    end
  end

  def down
    drop_table :events_locatinons
  end
end
