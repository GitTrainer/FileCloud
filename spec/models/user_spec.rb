require 'spec_helper'
describe User do

	before do
	   @user = User.new(name: 'KhanhHoang')
	end

	  subject { @user }

	  it { should respond_to(:name) }
	  it { should respond_to(:email) }
	  it { should respond_to(:password_digest) }
	  it { should respond_to(:status)}
	  it { should_not respond_to(:activate)}
	  it { should respond_to(:password_reset)}
	  it { should respond_to(:password_reset_sent_at)}
	  it { should respond_to(:authenticate)}
	  it { should respond_to(:send_resset_password)}

  	describe "when name is not valid" do
	    before { @user.name = " " }
	    it { should_not be_valid }
  	end

	# test duplicate email
	describe "when the mail is duplicate" do
		before do
			newuser=@user.dup # tao ra mot newuser la ban sao cua @user
			newuser.save
		end
		it {should_not be_valid}
	end

	# test length password
	describe "when name is not valid" do
	    before { @user.password = "khan" }
	    it { should_not be_valid }
  	end

  	# test confirmation password 
  	describe "when password_confirmation is mismatch" do
  		before do
  			@user.password="a"
  			@user.password_confirmation="b"
  			@user.save
  		end
  		it {should_not be_valid}
  	end

  	describe "send_resset_password" do
  		before {reset_email}
  		let(:user_activated){FactoryGirl.create(:user_activated)}
  		it "Generate password_reset unique each time" do
  			user_activated.send_resset_password
  			pr1=user_activated.password_reset
  			user_activated.send_resset_password
  			pr2=user_activated.password_reset
  			pr1.should_not eq(pr2)
  		end

  		it "Delivers email to user" do
  			reset_email  			
  			user_activated.send_resset_password
  			last_email.to.should include(user_activated.email)
  		end
  	end

end