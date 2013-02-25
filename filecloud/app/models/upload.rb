class Upload < ActiveRecord::Base
  attr_accessible :upload, :folder_id, :image, :user_id, :attachment_file_name, :upload_file_name
  validates :folder_id, :presence => true
  has_attached_file :upload
  belongs_to :folder
  belongs_to :user
  validate :validate_size

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

  def validate_size
    # binding.pry
    if upload.size > 3.megabytes
      errors.add :base, ("File must be less than 3MB")
    end
  end

end
