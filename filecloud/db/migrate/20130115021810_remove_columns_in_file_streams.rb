class RemoveColumnsInFileStreams < ActiveRecord::Migration
  def up
  end

  def down
  	remove_column :filestreams, :filename
  	remove_column :folders, :file
  end
end
