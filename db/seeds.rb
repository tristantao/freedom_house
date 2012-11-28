require 'dbf'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

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

  sources = [{:name => "Daily Trust", :home_page => "www.dailytrust.com.ng", :url => "http://www.dailytrust.com.ng/index.php/rss/xml/RSS2.0/full", :quality_rating => "10"}]

  sources.each do |source|
    Source.create!(source)
  end
=begin
  i = 0
  region_stat = DBF::Table.new('db/dbf/NGA.dbf')
  region_stat.each do |record|
    if (i % 10 == 0)
      puts "processed #{i} records"
    end
    Nigeria.create(:name => record.name, :f_class => record.f_class, :f_desig => record.f_desig, :lat => record.lat, :long => record.long, :state => record.adm1, :local_government => record.adm1)
    i += 1
  end
=end
