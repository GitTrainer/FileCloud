class AddCategoryIdToFolders < ActiveRecord::Migration
  def change
  	add_column :folders, :categoryID, :integer
  end
end
