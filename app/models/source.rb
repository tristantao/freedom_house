require 'open-uri'

class Source < ActiveRecord::Base

  has_many :articles
  belongs_to :user
  attr_accessible :name, :home_page, :url, :quality_rating
  validates :name, :home_page, :quality_rating, presence: true
  validates :quality_rating, :numericality => {only_integer: true}
  validates :url, rss: true

#In the future, should define a scrape method that sends to methods
#scrape_rss, scrape_htmlpage, scrape_twitter																																q 

  def scrape
     min_interval = 5 * 60
     if its_not_empty = !self.last_scraped.nil?
       its_too_early = Time.now - self.last_scraped.to_time < min_interval
     end
     unless its_too_early then
       rss_url = self.url
       doc = Nokogiri::HTML(open(rss_url))

       items = doc.css('channel item')

       items.each do |item|
         article = Article.new
         article.title = item.at_css('title').text
         article.link = item.at_css('link').next.text
         article.date = DateTime.parse(item.at_css('pubdate').text)
         article.source = self

         article.save if date > self.last_scraped
       end
       return nil
     else 
       return "Source #{source.name} was scraped less than #{min_interval/60} minutes ago."
     end
  end
end
