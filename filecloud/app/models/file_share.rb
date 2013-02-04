class FileShare < ActiveRecord::Base
  attr_accessible :file_up_load_id, :user_id

  validates :file_up_load_id,:presence=>true
  validates :user_id,:presence=>true

  belongs_to :user
  belongs_to :file_up_load
end
