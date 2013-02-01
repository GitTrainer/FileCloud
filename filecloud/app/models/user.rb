# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  login      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ActiveRecord::Base
  	
  	attr_accessible :email,:name, :login,:password, :password_confirmation,:password_reset, :password_reset_sent_at,:status,:avatar
    has_attached_file :avatar, :styles => { :medium => "400x600>", :thumb => "400x600>" }
   
    validates :name,  presence: true, length: { maximum: 50, minimum: 5 } 
    # validates :avatar, :attachment_presence => true
    # validates_with AttachmentPresenceValidator, :attributes => :avatar
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  	validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }
    validates :password, length: { maximum: 20, minimum: 5 },:if => :should_validate_password?
  	
    has_secure_password
  	before_save { |user| user.email = email.downcase }
  	before_save :create_remember_token
    has_many :folders,dependent: :destroy
   
    def send_resset_password
      self.password_reset_sent_at=Time.zone.now
      @pass=SecureRandom.urlsafe_base64
      self.password_reset=@pass
      save!(:validate => false)
      UserMailer.send_password(self).deliver
    end

  	private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
    
    def should_validate_password?
      self.new_record? || self.password!=""
    end
end
