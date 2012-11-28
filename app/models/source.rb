require 'open-uri'
require 'date'

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
     unless its_empty = self.last_scraped.nil? then
       its_too_early = Time.now - self.last_scraped.to_time >= min_interval
     end
     if !its_empty && its_too_early then
       return "Source #{self.name} was scraped less than #{min_interval/60} minutes ago."
     else 
       rss_url = self.url
       doc = Nokogiri::HTML(open(rss_url))

       items = doc.css('channel item')

       items.each do |item|
         article = Article.new
         article.title = item.at_css('title').text
         article.link = item.at_css('link').next.text
         article.date = DateTime.parse(item.at_css('pubdate').text)
         article.source = self

         article.save if (self.last_scraped.nil? || article.date > self.last_scraped)
       end
       self.last_scraped = DateTime.now
       return nil
     end
  end
end
