class AddCategoryAndNameToShip < ActiveRecord::Migration[6.1]
  def change
    change_table :ships, :bulk => true do |t|
      t.string :category
      t.string :name
    end
  end
end
