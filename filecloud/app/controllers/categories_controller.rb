class CategoriesController < ApplicationController
  before_filter :signed_in_user

	def index
		# binding.pry
		# search = Category.search(params[:search])
		# binding.pry
		if (@new_category.nil?)
			@new_category = Category.new
		end
		  @categories = Category.all
		  respond_to do |format|
		    format.html { render action: "index"}
		    format.js {render js: @new_category }
		    format.js {render js: @categories }
		  end
	end


		def search
			binding.pry
		  @categories = Category.search do
		    keywords params[:query]
		  end.results

		  respond_to do |format|
		    format.html { render :action => "index" }
		    format.xml  { render :xml => @categories }
		  end
		end







	def new
	  @new_category = Category.new
	end

	def create
	  @new_category = Category.new(params[:category])
		@categories = Category.all
		respond_to do |format|
		  if @new_category.save
     	  @new_category = nil
     	  format.html { redirect_to "/categories"}
          format.js {render js: @new_category }
          format.js {render js: @categories }
      else
        format.html { render action: "index"}
        format.js {render js: @new_category.errors, status: :unprocessable_entity}
        format.js {render js: @categories }
	    end
    end
	end

	def show
		# binding.pry
		# @search = Category.search(params[:search])
		@category = Category.find(params[:id])
		@folders = Folder.where(:category_id => params[:id],:user_id => current_user.id)
    respond_to do |format|
      format.html { render action: "show"}
      format.js {render js: @category }
    end
	end

	def edit
		@categories = Category.all
		@new_category = Category.find(params[:id])
		respond_to do |format|
		  format.html { render action: "index"}
		  format.js {render js: @new_category}
		  format.js {render js: @categories }
		end
	end

	def update
		@new_category = Category.find(params[:id])
		@categories = Category.all
		  respond_to do |format|
		    if @new_category.update_attributes(params[:category])
				  @new_category = nil
          format.html { redirect_to "/categories"}
          format.js { render js: @new_category }
		    else
          format.html {  render action: "index"}
          format.js {render js: @new_category.errors, status: :unprocessable_entity}
          format.js {render js: @categories }
        end
      end
	end

	def destroy
		@category = Category.find(params[:id])
		@category.destroy
		respond_to do |format|
		  format.html { redirect_to "/categories"}
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
