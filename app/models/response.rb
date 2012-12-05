class Response < ActiveRecord::Base

  belongs_to :feedback
  
  attr_accessible :commenter, :body, :created_at, :updated_at

  validates :commenter, :body, :created_at, :updated_at, :presence => :true

end
