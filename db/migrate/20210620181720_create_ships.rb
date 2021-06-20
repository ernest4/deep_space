class CreateShips < ActiveRecord::Migration[6.1]
  def change
    create_table :ships do |t|
      t.bigint :character_id
      t.string :battle_set, :default => "default"
      t.string :state
      t.integer :hitpoints
      t.string :category
      t.string :name
      t.timestamps
    end
  end
end
