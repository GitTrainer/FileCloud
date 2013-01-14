class FileUpLoad < ActiveRecord::Base
  attr_accessible :folder_id,:attach
  validates :folder_id, presence: true
  belongs_to :foler,dependent: :destroy
  has_attached_file :attach

end
