class UploadFile < ActiveRecord::Base
  attr_accessible :folder_id, :attach, :image
  validates :folder_id, presence: true
  belongs_to :folder
#  has_attached_file :attach

  include Rails.application.routes.url_helpers

  def to_jq_upload
    {
      "name" => read_attribute(:attach_file_name),
      "size" => read_attribute(:attach_file_size),
      "url" => attach.url(:original),
      "delete_url" => uploadfile_path(self),
      "delete_type" => "DELETE"
    }
	end
end
