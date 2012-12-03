class AddTitleandAdmintoFeedback < ActiveRecord::Migration
  def change
    add_column :feedbacks, :title, :string
    add_column :feedbacks, :adminresponse, :text
  end
end
