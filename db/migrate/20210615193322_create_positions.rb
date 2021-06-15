class CreatePositions < ActiveRecord::Migration[6.1]
  def change
    create_table :positions do |t|
      t.bigint  :x
      t.bigint  :y
      t.bigint  :positionable_id
      t.string  :positionable_type
      t.timestamps
    end

    add_index :positions, [:positionable_type, :positionable_id]
  end
end
