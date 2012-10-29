class UserController < ApplicationController


  def profile
    
  end

  def update
    @user = User.find(params[:id])
    if @user.update_with_password(params[:user])
      flash[:notice] = "Successfully updated your information!"
    else
      flash[:warning] = "Invalid input"
    end
    sign_in(@user, :bypass => true)
    redirect_to user_profile_path
  end
end
