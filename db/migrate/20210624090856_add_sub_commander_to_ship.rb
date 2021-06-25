class AddSubCommanderToShip < ActiveRecord::Migration[6.1]
  def change
    change_table :ships, :bulk => true do |t|
      t.bigint :sub_commander_id
    end

    remove_column :ships, :hitpoints
  end
end
