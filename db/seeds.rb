# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
  loc_blacklisted_months = ["January", "Jan", "February", "Feb", "March", "Mar", "April", "Apr", "May", "June", "Jun", "July", "Jul", "August", "Aug", "September", "Sept", "October", "November", "Nov", "December", "Dec"]
  loc_blacklisted_persons = ["Obama"]
  loc_blacklisted_general = []
  blacklist = loc_blacklisted_months + loc_blacklisted_persons + loc_blacklisted_general
  blacklist.each do |loc| 
    Blacklist.create(:word => loc)
  end
  
  users = [{:first_name => "Jose", :last_name => "Carrillo", :email => "jcarrillo7@berkeley.edu", :password => "cheeta19"},
           {:first_name => "Chris", :last_name => "Balcells", :email => "balcells@berkeley.edu", :password => "balcells"},
           {:first_name => "Felix", :last_name => "Li", :email => "felix.li@berkeley.edu", :password => "felixli"},
           {:first_name => "Tristan", :last_name => "Tao", :email => "tao.tristan@gmail.com", :password => "tristan"},
           {:first_name => "Justin", :last_name => "Chan", :email => "hellojustinchan@gmail.com", :password => "justin"},
           {:first_name => "Richard", :last_name => "Xia", :email => "rxia@eecs.berkeley.edu", :password => "aforgroup19"}]


  users.each do |user|
    a = User.new(user)
    a.admin = true
    a.save
  end


  sources = [{:name => "Daily Trust", :home_page => "www.dailytrust.com.ng", :url => "http://www.dailytrust.com.ng/index.php/rss/xml/RSS2.0/full", :quality_rating => "10"},
             {:name => "Times", :home_page => "www.nytimes.com", :url => "http://rss.nytimes.com/services/xml/rss/nyt/World.xml", :quality_rating => "1"}]

  sources.each do |source|
    Source.create!(source)
  end

