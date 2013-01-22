require 'spec_helper'

describe "upload_files/edit" do
  before(:each) do
    @upload_file = assign(:upload_file, stub_model(UploadFile,
      :folder_id => 1
    ))
  end

  it "renders the edit upload_file form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => upload_files_path(@upload_file), :method => "post" do
      assert_select "input#upload_file_folder_id", :name => "upload_file[folder_id]"
    end
  end
end
