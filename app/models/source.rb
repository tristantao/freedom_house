class Source < ActiveRecord::Base

  has_many :articles
  belongs_to :user
  attr_accessible :name, :url, :quality_rating

end
