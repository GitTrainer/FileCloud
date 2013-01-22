class AddIsShareColumnToFolderSharing < ActiveRecord::Migration
  def change
  	add_column :foldersharings, :isShare, :boolean
  end
end
