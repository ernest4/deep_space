class RenameStatusToStateOnCharacters < ActiveRecord::Migration[6.1]
  def change
    rename_column :characters, :status, :state
  end
end
