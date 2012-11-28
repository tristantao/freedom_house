class CreateHateSpeeches < ActiveRecord::Migration
  def change
    create_table :hate_speeches do |t|
      t.string :speaker
      t.text :body
      t.references :article

      t.timestamps
    end
    add_index :hate_speeches, :article_id
  end
end
