require 'spec_helper'

describe "EdituserPages" do
  subject{page}
  describe "edit user" do
  	let(:user) { FactoryGirl.create(:user) }
  	before {visit edit_user_path(user)}
  	describe "page edit" do 
  		it {should have_selector('h1', text: "Editing user")}
  	end
  end
end
