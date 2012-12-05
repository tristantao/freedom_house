class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.string :commenter
      t.text :body
      t.timestamps
    end
  end
end
