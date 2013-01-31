class Upload < ActiveRecord::Base
  attr_accessible :upload, :folder_id, :image, :user_id
  has_attached_file :upload, :styles =>{ :original => "50x50>", :thumb => "100x180>" }
  belongs_to :folder
  belongs_to :user

  include Rails.application.routes.url_helpers

  def to_jq_upload
    {
      "name" => read_attribute(:upload_file_name),
      "size" => read_attribute(:upload_file_size),
      "url" => upload.url(:original),
      "delete_url" => upload_path(self),
      "delete_type" => "DELETE" 
    }
  end

end
