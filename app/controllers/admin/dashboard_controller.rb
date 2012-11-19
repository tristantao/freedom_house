class Admin::DashboardController < ApplicationController

  before_filter :admin_user?
  before_filter :authenticate_user!

  def index
    @num_users = User.count(:distinct => true)
    @num_events = Event.count(:distinct => true)
    @num_sources = Source.count(:distinct => true)
    @num_articles = Article.count(:distinct => true)
    @latest_article = Article.all(:order => "date desc", :limit => 1)[0].try(:title)
    @latest_event = Event.all(:order =>"date desc", :limit => 1)[0].try(:name)
  end

  protected
  def admin_user?
    redirect_to root_path() unless user_signed_in? && current_user.admin?
  end

end
