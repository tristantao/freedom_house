class AddAssocResponse < ActiveRecord::Migration
  def change
    add_column :responses, :feedback_id, :integer
  end
end