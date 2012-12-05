require 'open-uri'
require 'date'
require 'readability'
require 'feedzirra'
require_relative '../../db/dbf/location_miner.rb'

class Source < ActiveRecord::Base

  has_many :articles
  belongs_to :user
  belongs_to :classifier

  attr_accessible :name, :home_page, :url, :quality_rating, :progress_content, :progress_classify, :progress_scrape, :progress_location, :queued
  validates :name, :home_page, :quality_rating, presence: true
  validates :quality_rating, :numericality => {only_integer: true}
  validates :url, rss: true
  validates :url, :uniqueness => true

#In the future, should define a scrape method that sends to methods
#scrape_rss, scrape_htmlpage, scrape_twitter

  def scrapable?
    min_interval = 5 * 60
    its_too_early = false
    if !self.last_scraped.nil? then
      its_too_early = (Time.now - self.last_scraped.to_time) <= min_interval
    end
    !its_too_early && !self.queued
  end

  def scrape
    begin
      puts "starting scraping"
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
      now = Time.now
      puts "scrapping"
      items.each do |item|
        puts scrape_percentage.to_s + "%"

        if item.published <= now
          article = Article.new
          article.title = item.title
          article.author = item.author
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
      self.progress_scrape = "25%"
      self.save

      if items.length != 0
        update_percentage = 25.0 / articles.length
      else
        update_percentage = 25
      end

      puts "content"
      articles.each do |article|
        puts content_percentage.to_s + "%"
        trial = 1
        begin
          article.scrapeContent!
        rescue OpenURI::HTTPError => e
          if trial < 3
            puts "retrying.. waiting 10 sec"
            trial+=1
            sleep(10.seconds)
            retry
          else
            puts "scrape content failed...deleting article"
            puts article.link
            article.delete
            articles.delete(article)
          end
        end

        content_percentage += update_percentage
        self.progress_content = content_percentage.to_s + "%"
        self.save
      end
      self.progress_content = "25%"
      self.save

      puts "location"
    #You can call the function with different Databases and a array/sub-array of article models, to mine for different locations.
      if articles.length != 0
        mine_location('db/dbf/NGA_CSV.TXT', 'db/dbf/NGA.dbf', articles, "Nigeria", 1, self)
        if Classifier.all.length != 0 and Calssifier.all[0].on_off
          puts "classifying"
          Classifier.all[0].classify(articles, self)
        end
      end
      self.progress_location = "25%"
      self.save

    ensure
      self.last_scraped = DateTime.now
      self.progress_scrape = "0%"
      self.progress_content = "0%"
      self.progress_location = "0%"
      self.progress_classify = "0%"
      self.queued = false
      self.save!
    end
  end
end
