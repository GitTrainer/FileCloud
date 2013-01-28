class CategoriesController < ApplicationController
  before_filter :signed_in_user
  before_filter :current_admin_category,only:[:new,:show,:edit,:destroy,:index]  
def new
  	@category=Category.new

  end

  def create
  	@category=Category.new(params[:category])
  	if @category.save
  		redirect_to :action=>'index'
  	else
  		render :action=>'new'
  		
  	end
  end

def show
	@category=Category.find(params[:id])
	
end

  def index
     @categorys=Category.all
  end

  def edit
  	@category=Category.find(params[:id])

  end

  def update
  	@category=Category.find(params[:id])
  	if @category.update_attributes(params[:category])
  		redirect_to :action=>'show'
  	else
  		render :action=>'edit'
  	end
  end

def destroy
	Category.find(params[:id]).destroy
	redirect_to categories_path
end

def current_admin_category 
     redirect_to current_user, notice: "You are not authorize access" unless current_user.admin?
  end
end
