require 'spec_helper'

describe"FileUpLoad pages" do

subject{page}
let(:f){FactoryGirl.create(:folder)}
 
 describe "new page" do
     before{visit '/file_up_loads/new?id='+f.id.to_s}
     it "upload file to server" do
      page.attach_file('file_up_load_attach', "#{Rails.root}"+"/spec/phongcanh.jpeg")
      click_button 'Up File' 
   end
 it{should have_link('Back',href:folder_path(f.id))}
end

end