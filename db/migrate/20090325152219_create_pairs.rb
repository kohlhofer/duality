class CreatePairs < ActiveRecord::Migration
  def self.up
    create_table :pairs do |t|
      t.belongs_to :creator
      t.string :item_1, :item_2
      t.timestamps
    end
    add_index :pairs, :creator_id
  end

  def self.down
    drop_table :pairs
  end
end
