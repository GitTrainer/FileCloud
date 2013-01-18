require 'spec_helper'

describe "ShowPages" do
  
  subject { page }

  describe "index" do
    before do
      sign_in FactoryGirl.create(:user)
      FactoryGirl.create(:user, name: "vandung", email: "ngvandung2010@gmail.com")
      visit users_path
    end
    it { should have_selector('h1',    text: 'Listing users') }
    it "should list each user" do
      User.all.each do |user|
        page.should have_link('li', text: user.name)
      end
    end
  end
end
