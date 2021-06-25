class CreateHulls < ActiveRecord::Migration[6.1]
  def change
    create_table :hulls do |t|
      t.string :state
      t.bigint :xp
      t.string :name
      t.text :description
      t.bigint :integrity
      t.bigint :max_integrity
      t.timestamps
    end
  end
end
