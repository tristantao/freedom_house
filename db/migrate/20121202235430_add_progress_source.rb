class AddProgressSource < ActiveRecord::Migration
  def up
    add_column :sources, :progress_scrape, :string, :default => "0%"
    add_column :sources, :progress_content, :string, :default => "0%"
    add_column :sources, :progress_classify, :string, :default => "0%"
    add_column :sources, :progress_location, :string, :default => "0%"
  end

  def down
    remove_column :sources, :progress_scrape, :string
    remove_column :sources, :progress_content, :string
    remove_column :sources, :progress_classify, :string
    remove_column :sources, :progress_location, :string
  end
end
