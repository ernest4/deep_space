class CreateParticipations < ActiveRecord::Migration[6.1]
  def change
    create_table :participations do |t|
      t.bigint  :character_id
      t.bigint  :participatable_id
      t.string  :participatable_type
      t.timestamps
    end

    add_index :participations, [:participatable_type, :participatable_id], :name => 'index_participations_on_participatable_type_and_its_id'
  end
end
