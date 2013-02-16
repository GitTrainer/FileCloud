class CategoriesController < ApplicationController
  before_filter :signed_in_user

  def index
    @search = Category.search(params[:search])
   	if ( @new_category.nil?)
	  	@new_category = Category.new
		end
    respond_to do |format|
      format.html { render action: "index"}
      format.js {render js: @search }
    end
	end

	def new
	  @new_category = Category.new
	end

	def create

	  @new_category = Category.new(params[:category])
		respond_to do |format|
		  if @new_category.save
        @new_category = nil
        @search = Category.search(params[:search])
     	  format.html { render action: "index"}
        format.js {render js: @new_category }
        format.js {render js: @search }
      else
				@search = Category.search(params[:search])
        format.html { render action: "index"}
        format.js {render js: @new_category.errors, status: :unprocessable_entity}
        format.js {render js: @search }
	    end
    end
	end

	def show
	  @category = Category.find(params[:id])
		@folders = Folder.where(:category_id => params[:id],:user_id => current_user.id)
 	  respond_to do |format|
    	format.html { render action: "show"}
    	format.js {render js: @category }
    end
	end

	def edit
		@search = Category.search(params[:search])
   	@new_category = Category.find(params[:id])
		respond_to do |format|
		  format.html { render action: "index"}
		  format.js {render js: @new_category}
		  format.js {render js: @search }
		end
	end

	def update
		@new_category = Category.find(params[:id])
	  respond_to do |format|
	    if @new_category.update_attributes(params[:category])
			  @new_category = nil
			  @search = Category.search(params[:search])
        format.html {  render action: "index"}
        format.js { render js: @new_category }
        format.js { render js: @search }
		  else
		  	@search = Category.search(params[:search])
        format.html {  render action: "index"}
        format.js {render js: @new_category.errors, status: :unprocessable_entity}
        format.js { render js: @search }
      end
    end
	end

	def destroy
		@category = Category.find(params[:id])
		@category.destroy
		respond_to do |format|
		   format.html {  render action: "index"}
		end
	end

  private
    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Please sign in."
      end
    end

end
