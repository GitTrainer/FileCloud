class UsersController < ApplicationController
  before_filter :set_mailer_host
  before_filter :authenticate_user!


  def index
    #    authorize! :index, @user, :message => 'Not authorized as an administrator.'
    @users = User.all
    #    @chart = create_chart
  end
  def password
    redirect_to('/')
  end

  def show
    #    @user = User.find(params[:id])
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  # GET /roles/1/edit
  def edit
    @search = User.search(params[:search])
    @users = @search.paginate(:per_page => 10, :page => params[:page])
    @user = User.find(params[:id])
    respond_to do |format|
      format.html { render action: "index"}
    end
  end

  # PUT /roles/1.json
  def update
    @user = User.find(params[:id])
    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to users_path, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def invite
    authorize! :invite, @user, :message => 'Not authorized as an administrator.'
    @user = User.find(params[:id])
    @user.send_confirmation_instructions
    redirect_to :back, :only_path => true, :notice => "Sent invitation to #{@user.email}."
  end

  def bulk_invite
    authorize! :bulk_invite, @user, :message => 'Not authorized as an administrator.'
    users = User.where(:confirmation_token => nil).order(:created_at).limit(params[:quantity])
    users.each do |user|
      user.send_confirmation_instructions
    end
    redirect_to :back, :only_path => true, :notice => "Sent invitation to #{users.count} users."
  end


  private

  def store_file
    File.open(file_storage_location, 'w') do |f|
      f.write uploaded_file.read
    end
  end

  def delete_file
    File.delete(file_storage_location)
  end

  def file_storage_location
    File.join(Rails.root, 'public', 'uploads', filename)
  end

  def set_filename
    self.filename = random_prefix + uploaded_file.original_filename
  end

  def random_prefix
    Digest::SHA1.hexdigest(Time.now.to_s.split(//).sort_by {rand}.join)
  end

end