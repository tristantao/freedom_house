class Article < ActiveRecord::Base

  belongs_to :source
  attr_accessible :title, :date, :text, :location, :author, :link
  validates :title, :date, :link, :presence => true
  validates :title, :uniqueness => {:scope => :date, :case_sensitive => false}
  acts_as_gmappable :process_geocoding => false

  def gmaps4rails_address
    "#{latitude}, #{longitude}"
  end
end
