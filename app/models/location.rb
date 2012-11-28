class Location < ActiveRecord::Base
  has_and_belongs_to_many :articles
  attr_accessible :name, :latitude, :longitude
  validates :name, :presence => true
end
