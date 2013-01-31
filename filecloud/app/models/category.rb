class Category < ActiveRecord::Base
  attr_accessible :description, :name, :user_id
  validates :name, presence: true, length: { maximum:50 },uniqueness: true
  validates :description, presence: true

  has_many :folders,dependent: :destroy
  belongs_to :user
end
