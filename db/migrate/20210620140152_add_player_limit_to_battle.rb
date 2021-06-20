class AddPlayerLimitToBattle < ActiveRecord::Migration[6.1]
  def change
    change_table :battles, :bulk => true do |t|
      t.integer :player_limit

      t.index :player_limit
    end
  end
end
