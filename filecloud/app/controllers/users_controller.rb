class UsersController < ApplicationController
  # GET /users
  # GET /users.json
  before_filter :signed_in_user, only: [:index]
  before_filter :correct_user, only: [:edit, :update]
  before_filter :admin_user, only: :destroy
  before_filter :set_mailer_host
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
    rescue ActiveRecord::RecordNotFound
    if @user 
      respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
      end  
    else
      render 'shared/notify'
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

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])
    if !User.find_by_email(@user.email)
      @activation_code=SecureRandom.urlsafe_base64
      @user.login=@activation_code
      respond_to do |format|
        if @user.save
          UserMailer.welcome_email(@user).deliver
          if !current_user
            format.html { redirect_to signin_url, notice: 'User was successfully created! Please check your email to Activate password' }
            format.json { render json: @user, status: :created, location: @user }
          else
            format.html { redirect_to users_url, notice: 'You have successfully created!' }
            format.json { render json: @user, status: :created, location: @user }
          end
        else
          format.html { render action: "new" }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    else
      flash.now[:notice]="Email exist! Please enter another email"
      render 'new'
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])
    respond_to do |format|
      if @user.update_attributes(params[:user])
        cookies.permanent[:remember_token] = @user.remember_token
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
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
    if @user.status==false
      if @user.login == params[:active_code]
        if @user.update_attribute(:status,true) && @user.update_attribute(:login,"activated")
          flash.now[:notice]='You have just activated your account'
          render 'sessions/new'
        else
          flash.now[:notice]='Errors'
          render 'sessions/new'
        end
      else
        flash.now[:notice]='The link is invalid! Please try again'
        render 'sessions/new'
      end
    else
      flash.now[:notice]='Your account have activated! Please sign In'
      render 'sessions/new'
    end
  end



    def signed_in_user
      redirect_to signin_url, notice: "Please sign in." unless signed_in?
    end
  private
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
end
