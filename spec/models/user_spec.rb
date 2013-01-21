require 'spec_helper'

describe "User" do

before do
    @user = User.new(name: "Van dung", email: "dung@gmail.com", 
                     password: "123456", password_confirmation: "123456")
  end

  subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to (:password_digest)}
  it { should respond_to (:password_confirmation)}
  it {should respond_to (:password)}
  it {should respond_to (:remember_token)}
  it {should respond_to (:authenticate)}
  it {should respond_to (:admin)}
  it {should_not be_admin}

  it {should be_valid}

  describe "when name is not present" do
  	before {@user.name= " "}
  	it { should_not be_valid}
  end
  describe "when emai is not present" do
  	before {@user.email= " "}
  	it { should_not be_valid}
  end
  describe "when name long character" do
  	before {@user.name="a"*51}
  	it {should_not be_valid}
  end
  
  describe "when email fomat is invalid" do
  	it "should be_valid" do
  		address=%w[user @foo,com user_at_foo.org example.user@foo.foo@bar_baz.com foo@bar+baz.com]
  		address.each do |invalid_address|
  			@user.email=invalid_address
  			@user.should_not be_valid
  		end
  	end
  end
  describe "when email format is valid" do
  	it "should be valid" do
  		address=%w[user@foo.COM A_US-ER@f.b.org first.lst@foo.jp a+b@baz.cn]
  		address.each do |valid_address|
  			@user.email=valid_address
  			@user.should be_valid
  		end
  	end
  end
  describe "when email is alreday taken" do
  	before do
  		user_with_same_email=@user.dup
  		user_with_same_email.email=@user.email.upcase
  		user_with_same_email.save
  	end 
  	it{should_not be_valid}
  end
  describe "when password_digest is not present" do
  	before {@user.password_digest=@user.password_confirmation=" "} 
  		
  		it {should_not be_valid}
  end
  
  describe "when password_confirmation miss" do
  	before {@user.password_confirmation="mismatch"}
  	it {should_not be_valid}
  end
  describe "when password_confirmation is nil" do
 	 before{@user.password_confirmation=nil}

  	it {should_not be_valid}
  end

  describe "return value of uathenticate method " do
  	before {@user.save}
  	let (:find_user) {User.find_by_email(@user.email)}

  	describe "with valid password" do
  		it {should==find_user.authenticate(@user.password)}
  	end
  	describe "with invalid password" do
  		let (:user_invalid_password) {find_user.authenticate("invalid")}
  		it {should_not==user_invalid_password}
  		specify {user_invalid_password.should be_false}
  	end
  end
  describe "email lowercase" do
  	let (:example_mail) {"ngvandung2010@GMAIL.cOm"}
  	it "should be save as all lowercase" do
  		@user.email=example_mail
  		@user.save
  		@user.reload.email.should== example_mail.downcase
    end
  end
  describe "remember token" do
  	before do
     @user.save
   end
  	# its(:remember_token) {should_not be_blank}
  	it {@user.remember_token.should_not be_blank}
  end
  describe "with user admin set to 'true'" do 
    before do
      @user.save!
      @user.toggle!(:admin)
    end
    it{should be_admin}
  end
 

   describe "send password reset" do
     let(:user) { FactoryGirl.create(:user) }
 
     # This fails
     context "generates a unique password_reset_token each time" do
       let(:user) { FactoryGirl.create(:user) }
       before do
         user.send_password_reset
         user.password_reset_token
         user.send_password_reset
       end
       its(:password_reset_token) { should_not == user.password_reset_token }
     end
       it "saves the time the password reset was sent" do
      user.send_password_reset
      user.reload.password_reset_sent_at.should be_present
    end

    it "delivers email to user" do
      user.send_password_reset
      last_email.to.should include(user.email)
    end
   end



end

