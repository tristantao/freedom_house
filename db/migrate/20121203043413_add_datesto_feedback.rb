class AddDatestoFeedback < ActiveRecord::Migration
  def change
    add_column :feedbacks, :date_created, :datetime
    add_column :feedbacks, :date_updated, :datetime
    add_column :feedbacks, :last_updated_user, :string
    remove_column :feedbacks, :adminresponse

    add_column :users, :adminresponse, :boolean, :default => false
  end
end
