class FileUpLoad < ActiveRecord::Base
  attr_accessible :folder_id,:attach
  validates :folder_id, presence: true
  validates :attach,presence:true
  belongs_to :folder 
  has_attached_file :attach



end
