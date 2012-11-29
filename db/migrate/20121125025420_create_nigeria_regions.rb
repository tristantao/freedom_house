class CreateNigeriaRegions < ActiveRecord::Migration
  def up
    create_table :nigeriaRegions, :force => true do |t|
      t.string :name
      t.string :f_class
      t.string :f_desig
      t.float :lat
      t.float :long
      t.string :state
      t.string :local_government

      t.timestamps
    end
  end

  def self.down
    drop_table :nigerias
  end
end
