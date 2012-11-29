class Location < ActiveRecord::Base
  has_and_belongs_to_many :articles
  has_and_belongs_to_many :events
  attr_accessible :name, :latitude, :longitude, :country, :gmaps
  validates :name, :presence => true
  acts_as_gmappable :process_geocoding => false

  def gmaps4rails_address
    return_loc = ""
    if (latitude != 0.0 && longitude != 0.0)
      return_loc = "#{latitude}, #{longitude}"
    else
      return_loc = "#{name}, #{country}"
    end
    return_loc
  end
end
