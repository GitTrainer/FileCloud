class Folderchilds < ActiveRecord::Migration
  def change
    create_table :folderchilds do |t|
			t.integer :parentID
			t.string :name
			t.string :description
      t.timestamps
    end
  end
end
