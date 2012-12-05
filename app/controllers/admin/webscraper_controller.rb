class Admin::WebscraperController < ApplicationController
  before_filter :admin_user?
  before_filter :authenticate_user!
  
  def index
    @sources = Source.all
    @classifier = Classifier.all[0].on_off
  end

  def scrape
    id = params[:id]
    source = Source.find_by_id(id)
    
    if not source.scrapable?
      flash[:warning] = "Source #{source.name} was scraped less than 5 minutes ago. Time is #{Time.now}."
    else 
      source.queued = true
      source.save
      source.delay.scrape
      flash[:notice] = "Source #{source.name} is being scrapped. You should see new articles, if any, in a few minutes."
    end
    
    redirect_to admin_webscraper_path
  end
  
  def scrapeAll
    sources = Source.all
    sources.each do |source|
      if source.scrapable?
        source.queued = true
        source.save
        source.delay.scrape
      end
    end
    redirect_to admin_webscraper_path
  end
  
  def accept_reject
    @articles = Article.find(:all, :conditions => {:admin_verified => nil})
    
  end
  
  def accept
    article = Article.find(params[:id])
    article.admin_verified = true
    article.contains_hatespeech = true
    article.save
    flash[:notice] = "Article #{article.id} has been accepted."
    redirect_to admin_webscraper_action_path(:accept_reject)
  end
  
  def reject
    article = Article.find(params[:id])
    article.admin_verified = false
    article.contains_hatespeech = false
    article.save
    flash[:warning] = "Article #{article.id} has been rejected."
    redirect_to admin_webscraper_action_path(:accept_reject)
  end
  
  def update_classifier
    status = params[:status]
    classifier_id = params[:classifier_id]
    classifier = Classifier.find(classifier_id)
    classifier.on_off = status == "true"
    classifier.save
  end
  
  def retrain
    Classifier.all[0].delay.retrain
    flash[:notice] = "Classifier is being retrained."
    redirect_to :back
  end

  protected
  def admin_user?
    redirect_to root_path() unless user_signed_in? && current_user.admin?
  end
end

