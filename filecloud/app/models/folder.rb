class Folder < ActiveRecord::Base
  attr_accessible :category_id, :description, :name, :user_id
  belongs_to :category, class_name: "Category"
  belongs_to :user
  has_many :filestreams, class_name: "Filestream", foreign_key: "folder_id", dependent: :destroy
  has_many :foldersharings, class_name: "Foldersharing", foreign_key: "folder_id", dependent: :destroy
  validates :name, :presence => true, :uniqueness => true
  validates :category_id, :presence => true
  validates :description, :presence => true
end
