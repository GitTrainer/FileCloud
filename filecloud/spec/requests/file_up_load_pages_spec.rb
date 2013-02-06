require 'spec_helper'

describe"FileUpLoad pages" do

subject{page}
let(:f){FactoryGirl.create(:folder)}
let(:user){FactoryGirl.create(:user)}
describe "new page" do
     before{visit '/file_up_loads/new?id='+f.id.to_s}
     it "upload file to server" do
       page.attach_file('file_up_load_attach', "#{Rails.root}"+"/spec/phongcanh.jpeg")
       click_button 'Up File' 
     end
    it{should have_link('Back',href:folder_path(f.id))}
end

describe "show page" do
   let(:file_up){FactoryGirl.create(:file_up_load)}
   before{visit file_up_load_path(file_up.id)}

   it {should have_selector('title',text:file_up.attach_file_name)}
   it {should have_selector('a',:value=>"+Share")}

   it "should have button 'Close'" do 
   	  page.should have_button ('Close')
   end

   it "should have button 'Share & Save'" do
   	  page.should have_button('Share & Save')
   end
   
   it "Should list member've shared" do
      file_up.file_shares.each do |file_share|
      page.should have_selector('td',text:file_share.user.name)
      page.should have_selector('td',text:file_share.user.email)
      page.check('activated[]')
      it "unshared file" do
           expect { click_button('Shave & Save') }.to change(FileShare, :count).by(-1)
         end
       end  
   end


   describe "Share file to other user" do
     before do
      fill_in "Email",   with:user.email
     end
      it "share file to user" do
        expect{click_button submit}.to change(FileShare,:count).by(1)
       end
    end   


end
end