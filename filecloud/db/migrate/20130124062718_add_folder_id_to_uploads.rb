class AddFolderIdToUploads < ActiveRecord::Migration
  def change
    add_column :uploads, :folder_id, :integer
    add_column :uploads, :image, :string
  end
end
