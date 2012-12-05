class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.text :description
      t.boolean :active
      t.integer :rating
      t.timestamps
    end
  end
end
