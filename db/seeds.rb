#!/bin/env ruby
# encoding: utf-8

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#this code was posted at: http://dev.mensfeld.pl/2011/10/handling-large-seed-files-in-ruby-on-rails/

%w{users sources articles}.each do |filename|
  require File.expand_path(File.dirname(__FILE__))+"/seeds/#{filename}.rb"
end

