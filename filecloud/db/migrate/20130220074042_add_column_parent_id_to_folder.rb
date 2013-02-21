class AddColumnParentIdToFolder < ActiveRecord::Migration
  def change
	  add_column :folders, :parentID, :integer
  end
end
