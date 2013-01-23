class Filesharing < ActiveRecord::Base
  attr_accessible :folder_id, :shared_user_id, :isShare
  belongs_to :folder, foreign_key: "folder_id", class_name: "Folder"
  belongs_to :user, foreign_key: "shared_user_id", class_name: "User"
end
