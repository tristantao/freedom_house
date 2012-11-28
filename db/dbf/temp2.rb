require 'dbf'
require 'csv'

def look_in_region(master_table, cache_table, region_hash,  key)
  if not cache_table.has_key?(key)
    rec = master_table.find :first, :name => region_hash[key]
    loc_long = rec.long.to_f
    loc_lat = rec.lat.to_f
    cache_table[key] = [loc_long, loc_lat] #caching
  else
    loc_long = cache_table[key][0]
    loc_lat = cache_table[key][1]
  end
  puts region_hash[key] + " " + loc_long.to_s + ", " + loc_lat.to_s
end

region_hash = {}

CSV.foreach('NGA_CSV.TXT', {:headers => true}) do |row|
  region_hash[row[0].downcase] = row[0]
end

puts "CSV input size: " + region_hash.size.to_s

master_table = DBF::Table.new('NGA.dbf')
puts "Loaded DBF Table"

cache_table = {:sample_location => [0.0, 0.0]} #Hash: {lower_name => [long, lat]}

IO.foreach('sample.txt') do |line|
  line.split.each_cons(2) do |current_word, next_word|
    k_1 = current_word
    k_2 = current_word + " " + next_word
    if region_hash.has_key?(k_1.downcase)
      key = k_1.downcase
      look_in_region(master_table, cache_table, region_hash, key)
    else region_hash.has_key?(k_2.downcase)
      key = k_2.downcase
      look_in_region(master_table, cache_table, region_hash,  key)
    end
  end
end
