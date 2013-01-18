class Filestream < ActiveRecord::Base
  attr_accessible :folder_id,:attach, :filename,:attach_content_type, :attach_file_name, :attach_file_size
  validates :attach, :presence => true
  validates :folder_id, :presence => true
  belongs_to :folder, class_name: "Folder"
  has_attached_file :attach
   include Rails.application.routes.url_helpers

  def to_jq_upload
    {
      "name" => read_attribute(:attach_file_name),
      "size" => read_attribute(:attach_file_size),
      "url" => attach.url(:original),
      "delete_url" => filestream_path(self),
      "delete_type" => "DELETE"
    }
  end


end
