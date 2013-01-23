class Folder < ActiveRecord::Base
  attr_accessible :description, :name, :category_id
  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
  validates :category_id, presence: true

  belongs_to :category 
  has_many :upload_files
end
