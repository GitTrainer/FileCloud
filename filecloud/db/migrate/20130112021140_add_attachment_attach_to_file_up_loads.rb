class AddAttachmentAttachToFileUpLoads < ActiveRecord::Migration
  def self.up
  add_column :file_up_loads, :attach_file_name, :string
  add_column :file_up_loads, :attach_content_type, :string
  add_column :file_up_loads, :attach_file_size, :integer
  
 end

 def self.down
  remove_column :file_up_loads, :attach_file_size
  remove_column :file_up_loads, :attach_content_type
  remove_column :file_up_loads, :attach_file_name
  
 end
end
