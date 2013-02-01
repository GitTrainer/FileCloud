class FileUpLoad < ActiveRecord::Base
  attr_accessible :folder_id,:attach
  validates :folder_id, presence: true
  validates_attachment :attach, :presence => true,
              :size => { :in => 0..2.megabytes }

  validates :attach,presence:true
  belongs_to :folder 
  has_attached_file :attach
  


end
