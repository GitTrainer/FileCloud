class FileUpLoad < ActiveRecord::Base
  attr_accessible :folder_id,:attach,:create_at
  validates :folder_id, presence: true
  validates_attachment :attach, :presence => true,
             :size => { :in => 0..2.megabytes }

  belongs_to :folder 
  has_attached_file :attach
  has_many :file_shares
  


end
