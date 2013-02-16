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

    describe "search file by name" do
        before do
            visit "/folders/#{folder.id}?direction=asc&sort=attach_file_name"
            fill_in "search",with: "down_row"
            click_button 'Search'
        end
        it {should have_content("down_row.png")}
        it {should have_selector('.tb-lst tr:nth-child(2) td:nth-child(2)',text:"down_row.png")}
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
    
    describe "count download file and sort" do
        
        let(:file1){FileUpLoad.find_by_attach_file_name("down_row.png")}
        let(:file2){FileUpLoad.find_by_attach_file_name("up_row.png")}
        before do
            i=0
            while i<10 do
                visit download_file_up_load_path(file1.id)
                if(i<5)
                    visit download_file_up_load_path(file2.id)
                end
                i+=1
            end
        end
        
        describe "cound download " do 
            before{visit folder_path(folder.id)}
            it {should have_selector('.tb-lst tr:nth-child(2) td:nth-child(6)',text:"10")}
            it {should have_selector('.tb-lst tr:nth-child(3) td:nth-child(6)',text:"5")}
        end

        describe "sort asc" do
            before {visit "/folders/#{folder.id}?direction=asc&sort=count_download" }
            it {should have_selector('.tb-lst tr:nth-child(2) td:nth-child(6)',text:"5")}
            it {should have_selector('.tb-lst tr:nth-child(3) td:nth-child(6)',text:"10")}
        end

        describe "sort desc" do
            before {visit "/folders/#{folder.id}?direction=desc&sort=count_download" }
            it {should have_selector('.tb-lst tr:nth-child(2) td:nth-child(6)',text:"10")}
            it {should have_selector('.tb-lst tr:nth-child(3) td:nth-child(6)',text:"5")}
        end
    end

end