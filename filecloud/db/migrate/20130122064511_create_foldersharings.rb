class CreateFoldersharings < ActiveRecord::Migration
  def change
    create_table :foldersharings do |t|
	  t.integer :folder_id
	  t.integer :shared_user_id
	  t.boolean :isShare
      t.timestamps
    end
  end
end
