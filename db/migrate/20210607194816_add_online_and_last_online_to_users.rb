class AddOnlineAndLastOnlineToUsers < ActiveRecord::Migration[6.1]
  def change
    # One by one...
    # add_column :users, :online, :boolean, :default => false
    # add_column :users, :last_online, :datetime

    # new bulk method for more than one row
    change_table :users, :bulk => true do |t|
      t.boolean :online, :default => false
      t.datetime :last_online
    end
  end
end
