require 'spec_helper'
require 'factory_girl'
require 'factory_girl_rails'
describe "Delete files" do

	subject { page }
	let(:user) { FactoryGirl.create(:user,:email=>"sormail@yaoo.com") }
	let(:folder) { FactoryGirl.create(:folder,:user_id=>user.id) }
	
    before do

        sign_in user
        visit '/file_up_loads/new?id='+folder.id.to_s
        page.attach_file('file_up_load_attach', "#{Rails.root}"+"/spec/up_row.png")
        click_button 'Start'

        visit '/file_up_loads/new?id='+folder.id.to_s
        page.attach_file('file_up_load_attach', "#{Rails.root}"+"/spec/down_row.png")
        click_button 'Start'

        visit '/file_up_loads/new?id='+folder.id.to_s
        page.attach_file('file_up_load_attach', "#{Rails.root}"+"/spec/down_row.png")
        click_button 'Start'

    end

    describe "Delete multi files" do
        before do
            visit "/folders/#{folder.id}?direction=asc&sort=attach_file_name"
            find(:css, "#file_ids_[value='1']").set(true)   
            find(:css, "#file_ids_[value='2']").set(true)        
        end
        it do
            expect { click_button('Delete files') }.to change(FileUpLoad, :count).by(-2)
        end
    end
end