class User < ActiveRecord::Base
  attr_accessible :email, :login, :name, :password, :password_confirmation,:status, :password_reset_token,
   :password_reset_sent_at, :admin, :created_at, :updated_at, :password_digest, :remember_token,
   :avatar
  has_many :folders
  has_attached_file :avatar, :styles => { :medium => "240x150>", :thumb => "100x100>" }
  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token
  has_many :filesharings, foreign_key: "shared_user_id", class_name: "Filesharing", dependent: :destroy
  has_many :foldersharing, foreign_key: "shared_user_id", class_name: "Foldersharing", dependent: :destroy
  has_secure_password
  validates :name, presence: true, length: { maximum: 50 }
  validates :password,
            :presence => true,
            :confirmation => true,
            :length       => { :minimum => 6 },
            :if => lambda{ new_record? || !password.nil? },
            :on => :create
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

   def send_password_reset
# binding.pry
      self.password_reset_token=SecureRandom.urlsafe_base64
      self.password_reset_sent_at = Time.zone.now
      save!(:validate => false)
      UserMailer.delay.password_reset(self)
      # binding.pry
    end

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end




    def self.search(search)
      if search
        find(:all, :conditions => ['name LIKE ?', "%#{search}%"])
      else
        find(:all)
      end
    end
end
