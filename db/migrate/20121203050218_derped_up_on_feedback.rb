class DerpedUpOnFeedback < ActiveRecord::Migration
  def change
    remove_column :feedbacks, :date_created
    remove_column :feedbacks, :date_updated
  end
end
