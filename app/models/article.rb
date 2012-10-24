class Article < ActiveRecord::Base

  belongs_to :source
  
  attr_accessible :title, :date, :text, :location, :author, :link

end
