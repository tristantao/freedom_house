require 'dbf'
require 'csv'

def look_in_region(master_table, cache_table, region_hash, key)
  if not cache_table.has_key?(key)
    rec = master_table.find :first, :name => region_hash[key]
    loc_long = rec.long.to_f
    loc_lat = rec.lat.to_f
    loc_count = 1
  else
    loc_long = cache_table[key][0]
    loc_lat = cache_table[key][1]
    loc_count = cache_table[key][2] + 1
  end
  cache_table[key] = [loc_long, loc_lat, loc_count] #inputting / updating the cache table
  puts region_hash[key] + " " + loc_long.to_s + ", " + loc_lat.to_s + ", " + loc_count.to_s
end

region_hash = {}

CSV.foreach('NGA_CSV.TXT', {:headers => true}) do |row|
  region_hash[row[0].downcase] = row[0]
end

puts "CSV input size: " + region_hash.size.to_s

master_table = DBF::Table.new('NGA.dbf')
puts "Loaded DBF Table"

cache_table = {:sample_location => [0.0, 0.0, 0.0]} #Hash: {lower_name => [long, lat, count]}

IO.foreach('sample.txt') do |line|
  n_gram = ""
  line.split.each do |current_word|
    if current_word.capitalize == current_word
      n_gram = n_gram + " " + current_word
      n_gram.strip!
      key = n_gram.downcase
      if region_hash.has_key?(key) #In Memory Hash of the db.
        look_in_region(master_table, cache_table, region_hash, key) #Actual query if it exists
      end
    else
      n_gram = "" #Not a Capital letter, start a new n_gram.
    end
  end
end
puts cache_table

=begin old algo
unigram = current_word
    bigram_is_valid = true
    if (unigram.capitalize != unigram) #the first word has to be capitalized
      next
    end
    bigram = current_word + " " + next_word
    if (next_word.capitalize != next_word)
      bigram_is_valid = false
    end
    if region_hash.has_key?(unigram.downcase)
      key = unigram.downcase
      look_in_region(master_table, cache_table, region_hash, key)
    elsif region_hash.has_key?(bigram.downcase) and bigram_is_valid
      key = bigram.downcase
      look_in_region(master_table, cache_table, region_hash, key)
    end
=end
