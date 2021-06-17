class CreateOccupations < ActiveRecord::Migration[6.1]
  def change
    create_table :occupations do |t|
      t.bigint  :character_id
      t.bigint  :occupiable_id
      t.string  :occupiable_type
      t.timestamps
    end

    add_index :occupations, [:occupiable_type, :occupiable_id]
  end
end
