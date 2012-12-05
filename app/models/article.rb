require 'readability'
require 'open-uri'
require_relative '../../db/dbf/location_miner.rb'

class Article < ActiveRecord::Base
  #will need to add a classifier_id field, so that we can retrieve articles specific to each different classifier.

  has_many :hate_speech
  belongs_to :source
  has_and_belongs_to_many :locations

  attr_accessible :title, :date, :text, :author, :link, :picture, :admin_verified, :contains_hatespeech

  validates :title, :date, :link, :presence => true
  validates :link, :uniqueness => true
  validates_link :link

  acts_as_gmappable :process_geocoding => false

  def gmaps4rails_address
    "#{latitude}, #{longitude}"
  end

  #Returns an array with all hate_speech linked to this article
  def hateArray
    hate_array = []
    self.hate_speech.each { |speech| hate_array.push(speech.body) }
    return hate_array
  end

  def scrapeContent!
    source = open(self.link).read
    doc =  Readability::Document.new(source, :ignore_image_format =>["gif"])
    self.text = doc.content
    if self.source.nil?
      name = self.link.match(/^http[s]?:\/\/[\w\d-]*[.]([\w\d-]+)/)
    else
      name = self.source.home_page.match(/^http[s]?:\/\/[\w\d-]*[.]([\w\d-]+)/)
    end
    if !name.nil?
      doc.images.each do |image|
        ad_match = image.downcase.match(/^http[s]?:\/\/[\w\d-]*[.]([\w\d-]+).[\w\d-]+\/(.*)/)
        if !ad_match.nil? && !ad_match[2].include?("ad")
          if image.include?(name[1])
            self.picture = image
            break
          end
        end
      end
    end
    self.save
  end

  def scrapeAll!
    self.scrapeContent!
    mine_location('db/dbf/NGA_CSV.TXT', 'db/dbf/NGA.dbf', [self], "Nigeria", 1, nil)
    if Classifier.all.legnth != 0 and Calssifier.all[0].on_off
      Classifier.all[0].classify([self], nil)
    end
  end

end
