class AddComposerToComponent < ActiveRecord::Migration[6.1]
  def change
    remove_column :components, :ship_id, :type => :bigint
    change_table :components, :bulk => true do |t|
      t.bigint  :composer_id
      t.string  :composer_type
    end

    add_index :components, [:composer_type, :composer_id]
  end
end
