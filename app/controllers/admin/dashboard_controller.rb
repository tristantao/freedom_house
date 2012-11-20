class Admin::DashboardController < ApplicationController

  before_filter :admin_user?
  before_filter :authenticate_user!

  def index
    @num_users = User.count(:distinct => true)
    @num_events = Event.count(:distinct => true)
    @num_sources = Source.count(:distinct => true)
    @num_articles = Article.count(:distinct => true)
    @latest_articles = Article.all(:order => "date desc", :limit => 5)
    @latest_events = Event.all(:order =>"date desc", :limit => 5)
    @new_articles = Article.where('date > ?', @current_user.last_sign_in_at.to_s).length
    @new_events = Event.where('date > ?', @current_user.last_sign_in_at.to_s).length
    @new_sources = Source.where('created_at > ?', @current_user.last_sign_in_at.to_s).length
    @num_messages = 0
  end

  protected
  def admin_user?
    redirect_to root_path() unless user_signed_in? && current_user.admin?
  end

end
