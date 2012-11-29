class Admin::WebscraperController < ApplicationController
  before_filter :admin_user?
  before_filter :authenticate_user!
  def index
    @sources = Source.all
  end

  def scrape
    id = params[:id]
    source = Source.find_by_id(id)
    result = source.scrape
    if result.nil?
      flash[:notice] = "Source #{source.name} has been successfully scraped!"
    else
      flash[:warning] = result 
    end
    redirect_to admin_webscraper_path
  end

  protected
  def admin_user?
    redirect_to root_path() unless user_signed_in? && current_user.admin?
  end
end

