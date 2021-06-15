class CreateAsteroids < ActiveRecord::Migration[6.1]
  def change
    create_table :asteroids do |t|
      t.string :name
      t.index :name, :unique => true
      t.timestamps
    end
  end
end
