class AddStateToBattle < ActiveRecord::Migration[6.1]
  def change
    change_table :battles, :bulk => true do |t|
      t.string :state

      t.index :state
    end
  end
end
