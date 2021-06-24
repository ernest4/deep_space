class AddStatsToShip < ActiveRecord::Migration[6.1]
  def change
    change_table :ships, :bulk => true do |t|
      t.integer :max_hitpoints
      t.integer :evasiveness_percent
      t.integer :accuracy_percent
      t.integer :armour
      t.integer :max_armour
      t.integer :shields
      t.integer :max_shields
      t.integer :xp
      t.integer :kills
      t.integer :shots
      t.integer :hits
      t.integer :evasions
      t.bigint :sub_commander_id
    end
  end
end
