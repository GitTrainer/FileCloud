class CategoriesController < ApplicationController
def index
@categories = Category.all
if ( @new_category.nil?)
	  @new_category = Category.new
end
          respond_to do |format|
             format.html { render action: "index"}
              format.js {render js: @new_category }
             end
end

def new
 @new_category = Category.new
end

def create
	 @new_category = Category.new(params[:category])
	  @categories = Category.all
       if @new_category.save
       	 @new_category = nil
       	 flash[:success] = "Created successfully"
         redirect_to categories_url
       else              
         respond_to do |format|
         format.html { render action: "index"}
         format.js {render js: @new_category.errors, status: :unprocessable_entity}
         format.js {render js: @categories }          
		 end
    end
end

def show	
	@category = Category.find(params[:id])
	@folders = Folder.where(:category_id => params[:id])
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
	@category = Category.find(params[:id])
	@categories = Category.all
       respond_to do |format|
         if @category.update_attributes(params[:category])
		  @category = nil                     
         format.html { redirect_to "/categories" }                     
                                                         
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

end
