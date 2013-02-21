class Upload < ActiveRecord::Base
  attr_accessible :upload, :folder_id, :image, :user_id, :attachment_file_name
  has_attached_file :upload
  belongs_to :folder
  belongs_to :user

  has_many :sharefiles, :dependent => :destroy

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

  def extension
    File.extname(attachment_file_name)[1..-1]
  end

end
