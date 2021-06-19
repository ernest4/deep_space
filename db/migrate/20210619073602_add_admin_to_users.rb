class AddAdminToUsers < ActiveRecord::Migration[6.1]
  def change
    change_table :users, :bulk => true do |t|
      t.boolean :admin, :default => false
    end
  end
end
