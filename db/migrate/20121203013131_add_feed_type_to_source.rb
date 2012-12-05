class AddFeedTypeToSource < ActiveRecord::Migration
  def up
    add_column :sources, :feed_type, :string, :default => 'RSS'
  end

  def down
    remove_column :sources, :feed_type
  end
end
