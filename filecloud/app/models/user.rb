class User < ActiveRecord::Base
  attr_accessible :email, :login, :name, :password, :password_confirmation,:status, :password_reset_token, :password_reset_sent_at, :admin
  has_many :folders
  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token
  has_many :filesharings, foreign_key: "shared_user_id", class_name: "Filesharing", dependent: :destroy
  has_many :foldersharing, foreign_key: "shared_user_id", class_name: "Foldersharing", dependent: :destroy
  has_secure_password
  validates :name, presence: true, length: { maximum: 50 }
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true
  # validates_presence_of :password
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

   def send_password_reset
      self.password_reset_token=SecureRandom.urlsafe_base64
      self.password_reset_sent_at = Time.zone.now
      save!(:validate => false)
      UserMailer.password_reset(self).deliver
    end

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end
