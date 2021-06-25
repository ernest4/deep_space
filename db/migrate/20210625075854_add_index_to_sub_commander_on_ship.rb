class AddIndexToSubCommanderOnShip < ActiveRecord::Migration[6.1]
  def change
    remove_column :ships, :sub_commander_id
    change_table :ships, :bulk => true do |t|
      t.bigint :sub_commander_id
      t.index :sub_commander_id
    end
  end
end
