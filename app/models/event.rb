class Event < ActiveRecord::Base

  belongs_to :article
  has_and_belongs_to_many :locations
  attr_accessible :name, :description, :date, :create_at
  validates :name, :description, :presence => true

end
