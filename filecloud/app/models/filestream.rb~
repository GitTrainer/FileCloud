class Filestream < ActiveRecord::Base
  attr_accessible :folder_id,:attach, :filename
  validates :folder_id, :presence => true
  validates :attach, :presence => true
  belongs_to :folder, class_name: "Folder"
  has_attached_file :attach

 
end
