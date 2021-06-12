class AddGoogleIdAndEmailToUsers < ActiveRecord::Migration[6.1]
  def change
    change_table :users, :bulk => true do |t|
      t.string :google_id
      t.string :email

      t.index :google_id
      t.index :email
    end
  end
end
