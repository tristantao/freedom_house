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
  
  protected
  def admin_user?
    redirect_to root_path() unless user_signed_in? && current_user.admin?
  end

end
