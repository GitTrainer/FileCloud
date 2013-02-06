require 'spec_helper'

describe "CounterPages" do
  let (:user) {FactoryGirl.create(:user)}
	before do
  		sign_in user

	end
	describe "Counter download" do
		let(:folder){FactoryGirl.create(:folder)}
    let(:filestream){FactoryGirl.create(:filestream)}
     before do
     	visit '/folders/?user_id=" + user.id.to_s'
     end
     	it "should click Download" do
					expect {click_button submit}.to change(Filestream,:download_count).by(1)
			end
	end
end
