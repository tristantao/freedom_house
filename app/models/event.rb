class Event < ActiveRecord::Base

  belongs_to :article
  attr_accessible :name, :description, :date, :longitude, :latitude, :country, :province, :city, :create_at
  validates :name, :description, :presence => true
  acts_as_gmappable :process_geocoding => false

  def gmaps4rails_address
    "#{latitude}, #{longitude}"
  end
end