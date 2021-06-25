class CreateComponents < ActiveRecord::Migration[6.1]
  def change
    create_table :components do |t|
      t.bigint  :ship_id
      t.bigint  :composable_id
      t.string  :composable_type
      t.timestamps
    end

    add_index :components, [:composable_type, :composable_id]
  end
end
