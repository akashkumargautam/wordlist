class CreateWords < ActiveRecord::Migration
  def self.up
    create_table :words do |t|
      t.column :wordvalue, :string, :null =>false
      end    
  end

  def self.down
    drop_table :words
  end
end