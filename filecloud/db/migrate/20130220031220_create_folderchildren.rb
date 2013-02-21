class CreateFolderchildren < ActiveRecord::Migration
  def change
    create_table :folderchildren do |t|
			t.integer :parentID
			t.string :name
			t.string :description
      t.timestamps
    end
  end
end
