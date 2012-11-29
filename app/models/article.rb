class Article < ActiveRecord::Base

  belongs_to :source
  has_and_belongs_to_many :locations
  attr_accessible :title, :date, :text, :author, :link
  validates :title, :date, :link, :presence => true
  validates :title, :uniqueness => {:scope => :date, :case_sensitive => false}
  acts_as_gmappable :process_geocoding => false

  def gmaps4rails_address
    "#{latitude}, #{longitude}"
  end
  
end
