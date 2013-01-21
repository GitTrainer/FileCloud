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

  	

end