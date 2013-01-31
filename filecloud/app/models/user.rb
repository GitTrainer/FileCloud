class User < ActiveRecord::Base
  has_and_belongs_to_many :roles
  has_attached_file :pic, :styles =>{ :medium => "500x300>", :thumb => "300x280>" }
  has_many :uploads
  has_many :folders

  has_attached_file :attach
  
  scope :admin, joins(:roles).where('roles.name = ?', 'admin')
  rolify
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
    :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :opt_in,:avatar_file_name,:avatar_content_type, :avatar_file_size,:avatar_updated_at,:pic
  #  attr_accessible :name, :email, :password, :password_confirmation, :remember_me
  # Setup accessible (or protected) attributes for your model
  attr_accessible :role_ids, :as => :admin
  #  attr_accessible :name, :email, :password, :password_confirmation, :remember_me

  # send mail after created
  after_create :add_user_to_mailchimp unless Rails.env.development?
  before_destroy :remove_user_from_mailchimp unless Rails.env.development?

  # override Devise method
  # no password is required when the account is created; validate password when the user sets one
  validates_confirmation_of :password
  def password_required?
    if !persisted? 
      !(password != "")
    else
      !password.nil? || !password_confirmation.nil?
    end
  end
  
  # override Devise method
  def confirmation_required?
    false
  end
  
  # override Devise method
  def active_for_authentication?
    confirmed? || confirmation_period_valid?
  end
  
  # new function to set the password
  def attempt_set_password(params)
    p = {}
    p[:password] = params[:password]
    p[:password_confirmation] = params[:password_confirmation]
    update_attributes(p)
  end
  
  # new function to determine whether a password has been set
  def has_no_password?
    self.encrypted_password.blank?
  end

  # new function to provide access to protected method pending_any_confirmation
  def only_if_unconfirmed
    pending_any_confirmation {yield}
  end
  # devise confirm! method overriden
  def confirm!
    #   welcome_message
    super
  end
    
  private

  def send_welcome_email
    unless self.email.include?('@gmail.com') && Rails.env != 'development'
      UserMailer.welcome_email(self).deliver
    end
  end


  def add_user_to_mailchimp
    unless self.email.include?('@gmail.com') or !self.opt_in?
      #get api key mail chimp from my account
      mailchimp = Hominid::API.new('b962bd251a86805250e44d7535e158d3-us6')
      list_id = mailchimp.find_list_id_by_name "visitors"
      info = { }
      result = mailchimp.list_subscribe(list_id, self.email, info, 'html', false, true, false, true)
      #      binding.pry
      Rails.logger.info("MAILCHIMP SUBSCRIBE: result #{result.inspect} for #{self.email}")
    end
  end
  
  def remove_user_from_mailchimp
    unless self.email.include?('@gmail.com')
      #get api key mail chimp from my account
      mailchimp = Hominid::API.new('1f410c8fd594f6676417db2e97b030fc-us6')
      list_id = mailchimp.find_list_id_by_name "visitors"
      result = mailchimp.list_unsubscribe(list_id, self.email, true, false, true)  
      Rails.logger.info("MAILCHIMP UNSUBSCRIBE: result #{result.inspect} for #{self.email}")
    end
  end

end