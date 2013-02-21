class Sharefile < ActiveRecord::Base
  attr_accessible :email, :upload_id
  validates :email, presence: true, uniqueness: true
  belongs_to :upload
  before_save :generate_token

    def generate_token
    self.link_token = SecureRandom.hex(10)
  end
end
