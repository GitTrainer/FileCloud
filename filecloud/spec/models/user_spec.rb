require 'spec_helper'

describe "User" do

  before do { @user = User.new(name: "vandung", email: "ngvandung2010@gmail.com") }
  end
  subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it {should be_valid}
end