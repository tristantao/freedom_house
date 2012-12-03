class Article < ActiveRecord::Base

  belongs_to :source
  has_and_belongs_to_many :locations

  attr_accessible :title, :contains_hatespeech, :date, :text, :author, :link, :picture

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

end
