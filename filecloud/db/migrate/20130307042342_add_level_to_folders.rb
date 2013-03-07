class AddLevelToFolders < ActiveRecord::Migration
  def change
  	add_column :folders, :level, :integer
  end
end
