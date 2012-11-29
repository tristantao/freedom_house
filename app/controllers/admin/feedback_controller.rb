class Admin::FeedbackController < ApplicationController
  before_filter :admin_user?
  before_filter :authenticate_user!
  
  protected
  def admin_user?
    redirect_to root_path() unless user_signed_in? && current_user.admin?
  end
end
