require 'spec_helper'
require 'factory_girl'
require 'factory_girl_rails'
describe "Order" do

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
    end

	describe "sort by name desc" do
    	before do
     		visit "/folders/#{folder.id}?direction=desc&sort=attach_file_name"
   		end
		it {should have_selector('.tb-lst tr:nth-child(2) td:nth-child(2)',text:"up_row.png")}
        it {should have_selector('.tb-lst tr:nth-child(3) td:nth-child(2)',text:"down_row.png")}
	end

    describe "sort by name asc" do
        before do
            visit "/folders/#{folder.id}?direction=asc&sort=attach_file_name"
        end
        it {should have_selector('.tb-lst tr:nth-child(3) td:nth-child(2)',text:"up_row.png")}
        it {should have_selector('.tb-lst tr:nth-child(2) td:nth-child(2)',text:"down_row.png")}
    end

    describe "sort by size desc" do
        let(:file1){FileUpLoad.find(1)}
        let(:file2){FileUpLoad.find(2)}
        before do
            visit "/folders/#{folder.id}?direction=desc&sort=attach_file_size"
        end
        it {should have_selector('.tb-lst tr:nth-child(3) td:nth-child(4)',text:file1.attach_file_size.to_s)}
        it {should have_selector('.tb-lst tr:nth-child(2) td:nth-child(4)',text:file2.attach_file_size.to_s)}
    end

    describe "sort by size asc" do
        let(:file1){FileUpLoad.find(1)}
        let(:file2){FileUpLoad.find(2)}
        before do
            visit "/folders/#{folder.id}?direction=asc&sort=attach_file_size"
        end
        it {should have_selector('.tb-lst tr:nth-child(2) td:nth-child(4)',text:file1.attach_file_size.to_s)}
        it {should have_selector('.tb-lst tr:nth-child(3) td:nth-child(4)',text:file2.attach_file_size.to_s)}
    end
    
end