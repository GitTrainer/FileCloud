class AddColumnToFolderTrees < ActiveRecord::Migration
	def change
    add_column :foldertrees, :parentID, :integer
    add_column :foldertrees, :name, :string
    add_column :foldertrees, :description, :string
  end
end
