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
           {:first_name => "Justin", :last_name => "Chan", :email => "hellojustinchan@gmail.com", :password => "justin"}]

  users.each do |user|
    a = User.new(user)
    a.admin = true
    a.save
  end
