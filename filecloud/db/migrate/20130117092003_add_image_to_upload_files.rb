class AddImageToUploadFiles < ActiveRecord::Migration
  def change
    add_column :upload_files, :image, :string
  end
end
