class SourceLastScraped < ActiveRecord::Migration
  def change
    add_column :sources, :last_scraped, :datetime, :default => nil
  end
end
