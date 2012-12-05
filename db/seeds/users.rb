#!/bin/env ruby
# encoding: utf-8

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
