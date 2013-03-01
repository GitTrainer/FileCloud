class Filestream < ActiveRecord::Base
  attr_accessible :folder_id,:attach, :filename,:attach_content_type, :attach_file_name, :attach_file_size, :download_count, :status
   
  validates :attach, :presence => true
  validates :folder_id, :presence => true
  belongs_to :folder, class_name: "Folder",foreign_key: "folder_id"
  has_many :filesharings, class_name: "Filesharing", foreign_key: "file_id", dependent: :destroy
  has_attached_file :attach
   include Rails.application.routes.url_helpers
  validate :size_validation
  def to_jq_upload
    {
    	"id"   => read_attribute(:id),
      "name" => read_attribute(:attach_file_name),
      "size" => read_attribute(:attach_file_size),
      "url" => attach.url(:original),
      "delete_url" => filestream_path(self),
      "delete_type" => "DELETE"
    }
  end
  def size_validation
    if attach.size > 5.megabytes
      errors.add :base, ("File must be less than 5MB")
    end
  end

  scope :filter_by_date, lambda { |date|
    date = date.split(",")[0]
    where(:created_at =>
      DateTime.strptime(date, '%m/%d/%Y')..DateTime.strptime(date, '%m/%d/%Y').end_of_day
    )
  }

    def self.search(search)
      if search
        find(:all, :conditions => ['attach_file_name LIKE ?', "%#{search}%"])
      else
        find(:all)
      end
    end



end
