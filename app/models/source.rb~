require 'open-uri'
require 'date'
require 'readability'
require 'feedzirra'
require_relative '../../db/dbf/location_miner.rb'

class Source < ActiveRecord::Base

  has_many :articles
  belongs_to :user
  attr_accessible :name, :home_page, :url, :quality_rating, :progress_content, :progress_classify, :progress_scrape, :progress_location
  validates :name, :home_page, :quality_rating, presence: true
  validates :quality_rating, :numericality => {only_integer: true}
  validates :url, rss: true

#In the future, should define a scrape method that sends to methods
#scrape_rss, scrape_htmlpage, scrape_twitter

  def scrape
    articles = []
    feed = Feedzirra::Feed.fetch_and_parse(self.url)
    items = feed.entries
    
    if items.length != 0
      scrape_update_percentage = 25.0 / items.length
    else
      scrape_update_percentage = 25
    end
    
    scrape_percentage = 0
    content_percentage = 0
    classify_percentage = 0
    location_percentage = 0
    
    self.progress_scrape = "0%"
    self.progress_content = "0%"
    self.progress_location = "0%"
    self.progress_classify = "0%"
    self.save
    
    puts "scrapping"
    items.each do |item|
      puts scrape_percentage.to_s + "%"
      if item.published <= Time.now
        article = Article.new
        article.title = item.title
        article.link = item.url
        article.date = item.published
        article.source = self
        if article.save
          puts "new article found"
          articles << article
        end
      end
      scrape_percentage += scrape_update_percentage
      self.progress_scrape = scrape_percentage.to_s + "%"
      self.save
    end
    
    if items.length != 0
      update_percentage = 25.0 / articles.length
    else
      update_percentage = 25
    end
    
    puts "content"
    articles.each do |article|
      puts content_percentage.to_s + "%"
      article.scrapeContent!
      content_percentage += update_percentage
      self.progress_content = content_percentage.to_s + "%"
      self.save
    end

    puts "location"
    #You can call the function with different Databases and a array/sub-array of article models, to mine for different locations.
    mine_location('db/dbf/NGA_CSV.TXT', 'db/dbf/NGA.dbf', articles, "Nigeria", 1)

    #mine_location('NGA_CSV.TXT', 'NGA.dbf', articles, 1)

    self.last_scraped = DateTime.now
    self.progress_scrape = "0%"
    self.progress_content = "0%"
    self.progress_location = "0%"
    self.progress_classify = "0%"
    self.save!
  end

end
