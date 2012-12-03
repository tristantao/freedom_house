require 'readability'

class Article < ActiveRecord::Base

  belongs_to :source
  has_and_belongs_to_many :locations

  attr_accessible :title, :date, :text, :author, :link, :picture

  validates :title, :date, :link, :presence => true

  has_many :hate_speech
  validates :title, :uniqueness => {:scope => :date, :case_sensitive => false}
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
    doc =  Readability::Document.new(source, :ignore_image_format =>["gif"], :min_image_height => 250, :min_image_width => 250 )
    self.text = doc.content
    self.picture = doc.images[0]
    self.save
  end

end
