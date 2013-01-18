class CreateUploadFiles < ActiveRecord::Migration
  def change
    create_table :upload_files do |t|
      t.integer :folder_id

      t.timestamps
    end
  end
end
