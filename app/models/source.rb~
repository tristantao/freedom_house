require 'open-uri'
require 'date'
require 'readability'
require 'feedzirra'
require_relative '../../db/dbf/location_miner.rb'

class Source < ActiveRecord::Base

  has_many :articles
  belongs_to :user
  attr_accessible :name, :home_page, :url, :quality_rating
  validates :name, :home_page, :quality_rating, presence: true
  validates :quality_rating, :numericality => {only_integer: true}
  validates :url, rss: true

#In the future, should define a scrape method that sends to methods
#scrape_rss, scrape_htmlpage, scrape_twitter

  def scrape
    articles = []
    feed = Feedzirra::Feed.fetch_and_parse(self.url)
    items = feed.entries
       
    items.each do |item|
      if item.published <= Time.now
        article = Article.new
        article.title = item.title
        article.link = item.url
        article.date = item.published
        article.source = self
        article.scrapeContent!
        articles << article
      end
    end
  
       
    mine_location('../../db/dbf/NGA_CSV.TXT', '../../db/dbf/NGA.dbf', articles)
       
    self.last_scraped = DateTime.now
    self.save
  end
  
end
