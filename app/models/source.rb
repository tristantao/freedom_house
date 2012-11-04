class Source < ActiveRecord::Base

  has_many :articles
  belongs_to :user
  attr_accessible :name, :home_page, :url, :quality_rating
  validates :name, :home_page, :quality_rating, :presence => true
  validates :quality_rating, :numericality => {:only_integer => true}
end
