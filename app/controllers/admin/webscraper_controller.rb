class Admin::WebscraperController < ApplicationController
  before_filter :admin_user?
  before_filter :authenticate_user!
  
  def index
    @sources = Source.all
  end

  def scrape
    id = params[:id]
    source = Source.find_by_id(id)
    min_interval = 5 * 60
    
    if !source.last_scraped.nil? then
      its_too_early = (Time.now - self.last_scraped.to_time) <= min_interval
    end
    
    if !source.last_scraped.nil? && its_too_early then
      flash[:notice] = "Source #{self.name} was scraped less than #{min_interval/60} minutes ago. Time is #{Time.now}."
    else 
      source.delay.scrape
      flash[:warning] = "Source #{source.name} is being scrapped. You should see new articles, if any, in a few minutes."
    end
    
    redirect_to admin_webscraper_path
  end

  protected
  def admin_user?
    redirect_to root_path() unless user_signed_in? && current_user.admin?
  end
end

