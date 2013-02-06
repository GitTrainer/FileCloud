require 'spec_helper'

describe FileShare do
	let(:user){FactoryGirl.create(:user)}
	let(:file_up){FactoryGirl.create(:file_up_load)}

	before do
	@file_share=file_up.file_shares.create(:user_id=>user.id)
    end
    subject{@file_share}

    it {should respond_to(:file_up_load_id)}
    it {should respond_to(:user_id)}

    its(:user){should==user}
    its(:file_up_load){should==file_up}
    
    it {should be_valid}

    describe "when user_id not present" do
    	
     before {@file_share.user_id=nil}
     it {should_not be_valid}
    end

    describe "when file_up_load_id not present" do
    	
     before {@file_share.file_up_load_id=nil}
     it {should_not be_valid}
    end


end
