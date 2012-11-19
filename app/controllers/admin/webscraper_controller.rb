class Admin::WebscraperController < ApplicationController

def index
  @sources = Source.all
end

def scrape
  id = params[:id]
  Source.find_by_id(id).scrape
  redirect_to admin_webscraper_path
end

end
