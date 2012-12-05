class AddQueuedToSources < ActiveRecord::Migration
  def change
    add_column :sources, :queued, :boolean, :default => false
  end
end
