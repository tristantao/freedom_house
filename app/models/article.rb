class Article < ActiveRecord::Base

  belongs_to :source
  attr_accessible :title, :date, :text, :location, :author, :link
  validates :title, :date, :link, :presence => true
  
  has_many :hate_speech
  acts_as_gmappable :process_geocoding => false

  def gmaps4rails_address
    "#{latitude}, #{longitude}"
  end
  
end
