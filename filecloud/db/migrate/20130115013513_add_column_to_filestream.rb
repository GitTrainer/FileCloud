class AddColumnToFilestream < ActiveRecord::Migration
  def up
    add_column :filestreams, :attach_file_name, :string
    add_column :filestreams, :attach_content_type, :string
    add_column :filestreams, :attach_file_size, :integer
  end
  
  def down
  	remove_column :filestreams, :filename
  end
end
