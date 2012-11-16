require 'open-uri'
class Source < ActiveRecord::Base

  has_many :articles
  belongs_to :user
  attr_accessible :name, :home_page, :url, :quality_rating
  validates :name, :home_page, :quality_rating, :presence => true
  validates :quality_rating, :numericality => {:only_integer => true}

  def scrape
     rss_url = self.url
     doc = Nokogiri::HTML(open(rss_url))

     articles = doc.css('channel item')

     articles.each do |article|
       title = article.at_css('title').text
       link = article.at_css('link').next.text
       date = article.at_css('pubdate').text
       Article.create!(:title => title, :link => link, :date => DateTime.parse(date))
     end
  end
end
