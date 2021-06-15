class AddUniqueConstraints < ActiveRecord::Migration[6.1]
  def change
    change_table :characters, :bulk => true do |t|
      t.index :name, :unique => true
    end

    remove_index :users, :google_id
    remove_index :users, :email
    change_table :users, :bulk => true do |t|
      t.index :google_id, :unique => true
      t.index :email, :unique => true
    end
  end
end
