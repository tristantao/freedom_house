class Admin::UsersController < ApplicationController
  before_filter :admin_user?
  before_filter :authenticate_user!

  def index
    @users = User.find(:all, :order => "first_name ASC")
  end

  def edit
    @user = User.find(params[:id])
    @sources = @user.sources
  end

  def update
    @user = User.find(params[:id])
    @user.admin = params[:user][:admin]
    @user.first_name = params[:user][:first_name]
    @user.last_name = params[:user][:last_name]
    @user.email = params[:user][:email]
    if @user.save
      flash[:notice] = "Successfully updated user!"
    else
      flash[:warning] = @user.errors.full_messages.join(". ") + "."
    end
    redirect_to admin_users_action_path(:edit, params[:id])
  end

  def new
    userinput = params[:user]

    if userinput
      is_admin = (userinput[:admin] == "true")
      a = User.create(:first_name => userinput[:first_name], :last_name => userinput[:last_name], :email => userinput[:email], :password_confirmation => userinput[:password_confirmation], :password => userinput[:password])
      a.admin = is_admin
      if a.save
        flash[:notice] = "User #{userinput[:first_name]} #{userinput[:last_name]} has been created!"
        redirect_to admin_users_path
      else
        flash[:warning] = a.errors.full_messages.join(". ") + "."
      end
    end
  end

  def delete
    @user = User.find_by_id(params[:id])
    firstname = @user.first_name
    lastname = @user.last_name
    @user.delete
    flash[:notice] = "User #{firstname} #{lastname} has been deleted."
    redirect_to admin_users_path
  end


  protected
  def admin_user?
    redirect_to root_path() unless user_signed_in? && current_user.admin?
  end

end
