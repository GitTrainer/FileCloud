class Filesharing < ActiveRecord::Base
  attr_accessible :folder_id, :shared_user_id
  belongs_to :filestream, foreign_key: "file_id", class_name: "Filestream"
  belongs_to :user, foreign_key: "shared_user_id", class_name: "User"
end
