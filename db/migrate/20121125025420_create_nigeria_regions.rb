class CreateNigeria < ActiveRecord::Migration
  def up
    create_table :nigerias, :force => true do |t|
      t.string :name
      t.string :f_class
      t.string :f_desig
      t.float :lat
      t.float :long
      t.string :state
      t.string :local_government

      t.timestamps
  end

  def self.down
    drop_table :nigerias
  end
end
