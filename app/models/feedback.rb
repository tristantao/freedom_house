class Feedback < ActiveRecord::Base
  belongs_to :user
  has_many :responses
  
  attr_accessible :description, :title, :active, :rating, :adminresponse, :last_updated_user, :created_at, :updated_at

  validates :title, :description, :rating, :presence => :true
  validates :rating, :numericality => {:only_integer => :true}

  
  
end
