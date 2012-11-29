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
class Loc
  include Comparable
  attr_accessor :name, :latitude, :langitude, :count
  def initialize(name, latitude, longitude, count)
    @name = name
    @latitude = latitude
    @longitude = longitude
    @count = count
  end
  def <=> (other)
    self.count <=> other.count
  end
end


def determine_relevant_loc(cache_table, tolerence)
  sum = 0
  partial_sum = 0

  location = []
  cache_table.each do |k, v|
    location << Loc.new(k, v[0], v[1], v[2])
    sum += v[2]
  end
  chosen_location = []
  location.sort! {|loc1, loc2| loc2 <=> loc1} #gives descending order
  puts "sorted location!"
  location.each do |temp|
    if (partial_sum / sum >= tolerence)
      break
    end
    partial_sum += temp.count
    chosen_location << temp
  end
  puts "Final Chosen Location"
  chosen_location.each do |loc|
    puts loc.name + ", " +loc.count.to_s
  end
end

def mine_location(csv_loc = 'NGA_CSV.TXT', dbf_loc = 'NGA.dbf', body_loc = 'sample.txt')
  region_hash = {}

  CSV.foreach(csv_loc, {:headers => true}) do |row|
    region_hash[row[0].downcase] = row[0]
  end

  puts "CSV input size: " + region_hash.size.to_s

  master_table = DBF::Table.new(dbf_loc)
  puts "Loaded DBF Table"

  cache_table = {:sample_location => [0.0, 0.0, 0.0]} #Hash: {lower_name => [long, lat, count]}

  IO.foreach(body_loc) do |line|
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
  return cache_table
end
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
