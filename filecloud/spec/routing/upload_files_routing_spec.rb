require "spec_helper"

describe UploadFilesController do
  describe "routing" do

    it "routes to #index" do
      get("/upload_files").should route_to("upload_files#index")
    end

    it "routes to #new" do
      get("/upload_files/new").should route_to("upload_files#new")
    end

    it "routes to #show" do
      get("/upload_files/1").should route_to("upload_files#show", :id => "1")
    end

    it "routes to #edit" do
      get("/upload_files/1/edit").should route_to("upload_files#edit", :id => "1")
    end

    it "routes to #create" do
      post("/upload_files").should route_to("upload_files#create")
    end

    it "routes to #update" do
      put("/upload_files/1").should route_to("upload_files#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/upload_files/1").should route_to("upload_files#destroy", :id => "1")
    end

  end
end
