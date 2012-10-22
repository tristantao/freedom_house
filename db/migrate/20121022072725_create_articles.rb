class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.datetime :date
      t.string :location
      t.string :link
      t.string :author

      t.timestamps
    end
  end
end
