class Filestream < ActiveRecord::Base
  attr_accessible :folder_id,:attach,:filename
  validates :folder_id, presence: true
  belongs_to :folder
  has_attached_file :attach

 
end
