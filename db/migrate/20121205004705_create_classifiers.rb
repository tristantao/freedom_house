class CreateClassifiers < ActiveRecord::Migration
  def change
    create_table :classifiers do |t|
      t.string :problem
      t.float :accuracy
      t.text :top_features
      t.boolean :on_off

      t.timestamps
    end
  end
end
