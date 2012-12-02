require 'open-uri'
require 'date'
require 'readability'
require 'feedzirra'


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
     min_interval = 5 * 60
     if its_not_empty = !self.last_scraped.nil? then
       its_too_early = Time.now - self.last_scraped.to_time >= min_interval
     end
     if its_not_empty && its_too_early then
       return "Source #{self.name} was scraped less than #{min_interval/60} minutes ago. Time is #{Time.now}."
     else 
       feed = Feedzirra::Feed.fetch_and_parse(self.url)
       items = feed.entries
       
       items.each do |item|
         if item.published <= Time.now
           article = Article.new
           article.title = item.title
           article.link = item.url
           article.date = item.published
           article.source = self
           article.scrapeContent
           article.save
         end
       end
       
       self.last_scraped = DateTime.now
       self.save
       return nil
     end
  end
end
