=begin
require_relative '../../db/dbf/location_miner.rb'
require 'descriptive_statistics'

#cache_t = mine_location('../../db/dbf/NGA_CSV.TXT', '../../db/dbf/NGA.dbf', '../../db/dbf/sample.txt')

Article.create(:title => "a1", :date => "2012/01/12", :link => "yahoo.com", :text => "Yesterday something happened in Jaji. I mean, Jaji. yes, Jaji. something definitely happened in Jaji. But also in Kaduna. stuff happened in Kaduna too! Kaduna is the name! yessssir!")

array = []
array << Article.find_by_title(:title => "a1")

cache_t = mine_location('../../db/dbf/NGA_CSV.TXT', '../../db/dbf/NGA.dbf', array, 1)

puts 'finished mining, returned hash to follow'

 a = []
puts a.sum
puts a.max.nil?
#determine_relevant_loc(cache_t, 0.75)
=end


