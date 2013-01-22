class User < ActiveRecord::Base
  attr_accessible :email, :login, :name, :password, :password_confirmation,:status, :password_reset_token, :password_reset_sent_at, :admin
  has_many :folders
  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token

  has_secure_password
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
#  validates :password, presence: true,length: { minimum: 6 }
#  validates :password_confirmation, presence: true
  #before_create {generate_token(:auth_token)}

   def send_password_reset
      self.password_reset_token=SecureRandom.urlsafe_base64

      self.password_reset_sent_at = Time.zone.now

      save!

       UserMailer.password_reset(self).deliver

    end



    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end







end
