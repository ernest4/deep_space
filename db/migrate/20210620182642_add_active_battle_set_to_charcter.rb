class AddActiveBattleSetToCharcter < ActiveRecord::Migration[6.1]
  def change
    change_table :characters, :bulk => true do |t|
      t.string :active_battle_set, :default => "default"
    end
  end
end
