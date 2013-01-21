class UsersController < ApplicationController
  # GET /users
  # GET /users.json
  before_filter :signed_in_user, only: [:index, :edit, :update, :destroy]
  before_filter :correct_user,   only: [:edit, :update]
  before_filter :admin_user,     only: :destroy
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

def create
    @user = User.new(params[:user])
    @code = SecureRandom.urlsafe_base64
    @user.login=@code
    if @user.save

      UserMailer.welcome_email(@user).deliver
      # Handle a successful save.
      flash[:success] = "Welcome to the Sample App! Please in your mail activate account"
      
      render 'sessions/new'
    else
      flash.now[:error]="errors"
      render 'new'
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  def activate
    
    @user=User.find(params[:id])
     if @user.login == params[:active_code]
      if @user.status != true
         
      
        #binding.pry
          if @user.update_attribute(:status, true)
            flash[:success] = "Welcome to the Sample App"
            render 'sessions/new'
      
          else
            flash[:success] = "Please activate in your mail"
            render 'sessions/new'
          end
        else
          signed_in_user
        end
    else
      flash[:success] = "errors"
      render 'sessions/new'   
    end  
  end

  private

    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Please sign in."
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end
     def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
    
    
end