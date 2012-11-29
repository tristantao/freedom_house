class Nigeria < ActiveRecord::Base

  attr_accessible :name, :f_class, :f_desig, :lat, :long, :state, :local_government
  validate :name, :presence => true
end
