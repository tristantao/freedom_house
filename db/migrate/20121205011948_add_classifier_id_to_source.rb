class AddClassifierIdToSource < ActiveRecord::Migration
  def change
    add_column :sources, :classifier_id, :integer, :default => 1
  end
end
