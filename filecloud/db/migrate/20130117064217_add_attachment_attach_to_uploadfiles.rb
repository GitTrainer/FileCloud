class AddAttachmentAttachToUploadfiles < ActiveRecord::Migration
#   def self.up
#     change_table :uploadfiles do |t|
#       t.attachment :attach
#     end
#   end

#   def self.down
#     drop_attached_file :uploadfiles, :attach
#   end
# end
  def self.up
  add_column :upload_files, :attach_file_name, :string
  add_column :upload_files, :attach_content_type, :string
  add_column :upload_files, :attach_file_size, :integer
  
 end

 def self.down
  remove_column :upload_files, :attach_file_size
  remove_column :upload_files, :attach_content_type
  remove_column :upload_files, :attach_file_name
  
 end
end