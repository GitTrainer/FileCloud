require 'spec_helper'

describe "Users" do
  describe "Edit page" do
  	it "should have the h1 'Editing user'" do
  		visit '/users/edit'
  		page.should have_selector( 'h1', text: 'Editing user')
  	end

  end
  describe "New page" do
  	it "should have the h1 'New user'" do
  		visit '/users/new'
  		page.should have_selector( 'h1', text: 'New user')
  	end

  end
  describe "Index page" do
  	it "should have the h1 'Listing users'" do
  		visit '/users/index'
  		page.should have_selector( 'h1', text: 'Listing users')
  	end

  end
end

