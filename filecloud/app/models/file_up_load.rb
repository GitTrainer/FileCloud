class FileUpLoad < ActiveRecord::Base
  attr_accessible :folder_id,:attach,:create_at
  validates :folder_id, presence: true
  validates_attachment :attach, :presence => true,
             :size => { :in => 0..2.megabytes }

  belongs_to :folder 
  has_attached_file :attach
  has_many :file_shares,dependent: :destroy
  include Rails.application.routes.url_helpers

  def to_jq_upload
    {
      "name" => read_attribute(:attach_file_name),
      "size" => read_attribute(:attach_file_size),
      # "url" => attach.url(:original),
      "url"=>file_up_load_path(self),
      "delete_url" => file_up_load_path(self),
      "delete_type" => "DELETE" 

    }
  end
	def self.search(search)
	  if search
	    where('attach_file_name LIKE ?', "%#{search}%")
	  else
	    scoped
	  end
	end
end
