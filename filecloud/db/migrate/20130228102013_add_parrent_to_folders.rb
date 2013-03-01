class AddParrentToFolders < ActiveRecord::Migration
  def change
    add_column :folders, :parentId, :integer
  end
end
