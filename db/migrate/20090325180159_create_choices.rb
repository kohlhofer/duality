class CreateChoices < ActiveRecord::Migration
  def self.up
    create_table :choices do |t|
      t.belongs_to :user
      t.belongs_to :pair
      t.integer :item

      t.timestamps
    end
    add_index :choices, [:user_id, :pair_id]
  end

  def self.down
    drop_table :choices
  end
end
