class CategoriesController < ApplicationController
  before_filter :authenticate_user!
  # GET /categories
  # GET /categories.json
  def index
    # @categories = Category.all

    @search =Category.search(params[:search])  
    @categories = @search.paginate(:per_page => 10, :page => params[:page])


  # @search =Category.search(params[:search])  
  #   @categories = @search.paginate(:per_page => 2, :page => params[:page])

    if current_user.has_role? :admin
      @categories=Category.all

    else
    

    @categories=Category.where(:user_id=>current_user.id)
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @categories }
    end
  end
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
     # binding.pry
     #@category = Category.where(:user_id=>current_user.id)
    # @category = Category.find_by_sql(["select * from categories c  join folders f on c.id=f.category_id where f.user_id=?",current_user.id])
     @category = Category.find(params[:id])
    

    respond_to do |format|
      format.html { render action: "show" } # show.html.erb
      format.json { render json: @category }
    end
  end

  # GET /categories/new
  # GET /categories/new.json
  def new
    @category = Category.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @category }
    end
  end

  # GET /categories/1/edit
  def edit
    @search = Category.search(params[:search])
    @categories = @search.paginate(:per_page => 10, :page => params[:page])

    @categories=Category.where(:user_id=>current_user.id)


    @category = Category.find(params[:id])
    respond_to do |format|
      format.html { render action: "index"}
    end
  end

  # POST /categories
  # POST /categories.json
  def create
     # binding.pry
    @category = Category.new(params[:category])

    respond_to do |format|
      if @category.save
        format.html { redirect_to categories_path, notice: 'Category was successfully created.' }
        format.json { render json: @category, status: :created, location: @category }
      else

         format.html { redirect_to categories_path, notice: 'Category errors.' }

        format.html { render action: "index" }

        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /categories/1
  # PUT /categories/1.json
  def update
    @category = Category.find(params[:id])

    respond_to do |format|
      if @category.update_attributes(params[:category])
        format.html { redirect_to categories_path, notice: 'Category was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    @category = Category.find(params[:id])
    @category.destroy

    respond_to do |format|
      format.html { redirect_to categories_url }
      format.json { head :no_content }
    end
  end
end
