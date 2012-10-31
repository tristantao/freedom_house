class Source < ActiveRecord::Base

  has_many :articles
  belongs_to :user
  attr_accessible :name, :home_page, :url, :quality_rating
  validate :name, :home_page, :presence => true
end
