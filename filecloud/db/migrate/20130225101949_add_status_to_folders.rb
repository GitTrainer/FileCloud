class AddStatusToFolders < ActiveRecord::Migration
  def change
  	add_column :folders, :status, :boolean, :default => false
  end
end
