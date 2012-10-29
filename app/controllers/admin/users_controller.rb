class Admin::UsersController < ApplicationController

  before_filter :admin_user?

  def index
    @users = User.find(:all, :order => "first_name ASC")
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.admin = params[:user][:admin]
    if @user.save
      flash[:notice] = "Successfully updated user!"
    else
      flash[:warning] = "Invalid Input"
    end
    redirect_to admin_users_action_path(:edit, params[:id])
  end

  def new
    userinput = params[:user]

    if userinput
      is_admin = (userinput[:admin] == "true")
      a = User.create(:first_name => userinput[:first_name], :last_name => userinput[:last_name], :email => userinput[:email], :password => userinput[:password])
      a.admin = is_admin
      if a.save
        flash[:notice] = "User #{userinput[:first_name]} #{userinput[:last_name]} has been created!"
      else
        flash[:notice] = "Error in creating user. Please try again."
      end
    end
  end

  def delete
    @user = User.find_by_id(params[:id])
    firstname = @user.first_name
    lastname = @user.last_name
    @user.delete
    flash[:notice] = "User #{firstname} #{lastname} has been deleted."
    redirect_to admin_dashboard_path
>>>>>>> 0d2cfed9193b9c26fd2a6a404797a1c7697e766c
  end


  protected
  def admin_user?
    redirect_to root_path() unless user_signed_in? && current_user.admin?
  end

end
