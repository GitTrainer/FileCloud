require "spec_helper"

describe UserMailer do
  before(:all) do
    @user = FactoryGirl.create(:user, email: "vu.duc.tuan@framgia.com")
    @email = UserMailer.welcome_email(@user).deliver
      
  end

  subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }

  it "should be delivered to the email address provided" do
    @email.should deliver_to("vu.duc.tuan@framgia.com")
  end

  it "should contain the correct message in the mail body" do
    @email.should have_body_text(/Welcome/)
  end
end


