require 'spec_helper'

describe User do
  
  before(:each) do
    @attr = { 
      :name => "Test User",
      :email => "framgiatest@framgia.com",
      :password => "framgia@123456",
      :password_confirmation => "framgia@123456"
    }
  end
  
  it "should create a new instance given a valid attribute" do
    User.create!(@attr)
  end
  
  it "should require an email address" do
    no_email_user = User.new(@attr.merge(:email => ""))
    no_email_user.should_not be_valid
  end
  
  it "should accept valid email addresses" do
    addresses = %w[user@gmail.com THE_USER@foo.bar.org first.last@gmail.jp]
    addresses.each do |address|
      valid_email_user = User.new(@attr.merge(:email => address))
      valid_email_user.should be_valid
    end
  end
  
  it "should reject invalid email addresses" do
    addresses = %w[user@gmail,com user_at_foo.org example.user@gmail.]
    addresses.each do |address|
      invalid_email_user = User.new(@attr.merge(:email => address))
      invalid_email_user.should_not be_valid
    end
  end
  
  it "should reject duplicate email addresses" do
    User.create!(@attr)
    user_with_duplicate_email = User.new(@attr)
    user_with_duplicate_email.should_not be_valid
  end
  
  it "should reject email addresses identical up to case" do
    upcased_email = @attr[:email].upcase
    User.create!(@attr.merge(:email => upcased_email))
    user_with_duplicate_email = User.new(@attr)
    user_with_duplicate_email.should_not be_valid
  end
  
  describe "passwords" do

    before(:each) do
      @user = User.new(@attr)
    end

    it "should have a password attribute" do
      @user.should respond_to(:password)
    end

    it "should have a password confirmation attribute" do
      @user.should respond_to(:password_confirmation)
    end
  end
  
  describe "password validations" do

    it "should require a password" do
      User.new(@attr.merge(:password => "", :password_confirmation => "")).
        should_not be_valid
    end

    it "should require a matching password confirmation" do
      User.new(@attr.merge(:password_confirmation => "invalid")).
        should_not be_valid
    end
    
    it "should reject short passwords" do
      short = "a" * 5
      hash = @attr.merge(:password => short, :password_confirmation => short)
      User.new(hash).should_not be_valid
    end
    
  end
  
  describe "password encryption" do
    
    before(:each) do
      @user = User.create!(@attr)
    end
    
    it "should have an encrypted password attribute" do
      @user.should respond_to(:encrypted_password)
    end

    it "should set the encrypted password attribute" do
      @user.encrypted_password.should_not be_blank
    end

  end

  #login
  describe "Login system" do

    context "User signin system" do

      it "shows error for not confirmed users after signin" do
        visit "/"
        fill_in "email", :with => "framgiatest@framgia.com"
        fill_in "password", :with => "framgia@123456"
        click_button "user_submit"
        page.should have_content(I18n.t('devise.failure.invalid'))
      end

    end
  end

  describe 'should be able to signin with admin' do
    before do
      visit '/'
      #test with user admin login
      user = FactoryGirl.create(:admin)
      
      fill_in 'email', with: user.email
      fill_in 'password', with: user.password
      click_on 'Sign in'
    end
    it { should have_link 'Logout' }
  end

  describe "should be able to signin with admin" do
    before(:each) do
      @admin = FactoryGirl.create(:admin)

      visit '/'
      click_link "Sign_in"
      fill_in "email",  :with => @admin.email
      fill_in "password", :with => 'valid'
      click_button "Sign in"
    end
  end
    
  describe "Admin panel" do
    it "should have correct links" do
      click_link "User"
      response.should be_success
    end
  end


  describe 'should wrong value signin' do
    before do
      visit '/'
      fill_in "email",:with => "invalid"
      fill_in "password", :with => "valid"
      click_button "user_submit"
      page.should have_content(I18n.t('devise.failure.invalid'))
    end
  end
  #Register system
  describe 'should be able to Register' do
    after do
      visit 'localhost:3000'
      click_link "Didn't receive confirmation instructions?"
      visit 'users/confirmation/new'
      fill_in "email", :with => "valid"
      click_button "Send me reset password instructions"
      @email.should deliver_to("vu.duc.tuan@framgia.com")

      it "should contain the correct message in the mail body and token actived link" do
        @email.should have_body_text(/Welcome/)
      end
    end
  end


  describe "Sign_out" do
    it "user can logout system" do
      test_sign_in(Factory(:user))
      delete :destroy
      controller.should_not be_signed_in
      response.should redirect_to(root_path)
    end
  end

end