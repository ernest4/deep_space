class AddStatusToCharacter < ActiveRecord::Migration[6.1]
  def change
    change_table :characters, :bulk => true do |t|
      t.string :status

      t.index :status
    end
  end
end
