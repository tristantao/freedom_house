class Admin::WebscraperController < ApplicationController

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

end

