require 'spec_helper'

describe FileShare do
	let(:user){FactoryGirl.create(:user)}
	let(:file_up){FactoryGirl.create(:file_up_load)}

	before do
	@file_share=file_up.file_shares.create(:user_id=>user.id)
    end
    subject{@file_share}

    it {shuold respond_to(:file_up_load_id)}
    it {shuold respond_to(:user_id)}

    its(:user){shuold==user}
    its(:file_up_load){should==file_up}
    
    it {shuold be_valid}

    describe "when user_id not present" do
    	
     before {@file_share.user_id=nil}
     it {shuold_not be_valid}
    end

    describe "when file_up_load_id not present" do
    	
     before {@file_share.file_up_load_id=nil}
     it {shuold_not be_valid}
    end


end
