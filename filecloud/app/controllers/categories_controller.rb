class CategoriesController < ApplicationController
  
  before_filter :authenticate_user!
  # GET /categories
  # GET /categories.json
  def index
    # @categories = Category.all
    @search =Category.search(params[:search])  
<<<<<<< HEAD
    @categories = @search.paginate(:per_page => 2, :page => params[:page])
=======
    @categories = @search.paginate(:per_page => 10, :page => params[:page])
>>>>>>> 35aa85ccb23d02f075503d57a924b35fab6d0fb9

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @categories }
    end
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
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

    @category = Category.find(params[:id])
    respond_to do |format|
      format.html { render action: "index"}
    end
  end

  # POST /categories
  # POST /categories.json
  def create
<<<<<<< HEAD
     # binding.pry
=======
    # binding.pry
>>>>>>> 35aa85ccb23d02f075503d57a924b35fab6d0fb9
    @category = Category.new(params[:category])

    respond_to do |format|
      if @category.save
        format.html { redirect_to categories_path, notice: 'Category was successfully created.' }
        format.json { render json: @category, status: :created, location: @category }
      else
<<<<<<< HEAD
         format.html { redirect_to categories_path, notice: 'Category errors.' }
=======
        format.html { redirect_to categories_path, notice: 'Category errors.' }
>>>>>>> 35aa85ccb23d02f075503d57a924b35fab6d0fb9
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
