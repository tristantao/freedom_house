require 'dbf'
require 'csv'
require 'descriptive-statistics'

def look_in_region(master_table, master_cache_table, individual_cache_table, region_hash, key)
  if not master_cache_table.has_key?(key) #simply populate the table if it isn't in there.
    rec = master_table.find :first, :name => region_hash[key]
    begin
      target_long = rec.long.to_f
    rescue TypeError
      target_long = -181.0
    end
    begin
      target_lat = rec.lat.to_f
    rescue TypeError
      target_lat = -91.0
    end
    master_cache_table[key] = [target_long, target_lat]
  end
  #the following should always be available, after the previous lines
  loc_long = master_cache_table[key][0]
  loc_lat = master_cache_table[key][1]

  if individual_cache_table.has_key?(key)
    loc_count = individual_cache_table[key][2] + 1
  else
    loc_count = 1
  end
  individual_cache_table[key] = [loc_long, loc_lat, loc_count]
end
class Loc
  include Comparable
  attr_accessor :name, :longitude, :latitude, :count
  def initialize(name, longitude, latitude, count)
    @name = name
    @latitude = latitude
    @longitude = longitude
    @count = count
  end
  def <=> (other)
    self.count <=> other.count
  end
end


def determine_relevant_loc_and_save(article, individual_cache_table, region_hash, country, tolerence)
  locations = []
  counts_array = []
  individual_cache_table.each do |k, v|
    locations << Loc.new(k, v[0], v[1], v[2])
    counts_array << v[2]
  end
  puts "Target counts:"
  puts counts_array

  chosen_location = []
  locations.sort! {|loc1, loc2| loc2 <=> loc1} #gives descending order
  puts "sorted location!"

  descriptive_counts_array = DescriptiveStatistics.new(counts_array)
  max_count = descriptive_counts_array.max #nil if nothing in array
  sum_count = descriptive_counts_array.sum
  sd_count = descriptive_counts_array.standard_deviation
  if max_count.nil? #nothing in the array
    max_count = 0
    sum_count = 0
  end
  if sd_count.nil? #is nil when array.size == 0. so setting it to 0.
    sd_count = 0
  end

 # puts max_count
 # puts sum_count
 # puts sd_count
  count_threshhold = max_count - (tolerence * sd_count)
  locations.each do |temp|
    if temp.count < count_threshhold
      break
    end
    chosen_location << temp
  end
  chosen_location.each do |loc|
    puts "\nChosen"
    puts loc.name + ", " +loc.count.to_s
    db_loc = Location.find_by_name(region_hash[loc.name])
    if db_loc.nil?
      if loc.latitude < -90.0 or loc.longitude < -180.0
        db_loc = Location.new(:name => region_hash[loc.name], :country => country)
      else
        db_loc = Location.new(:name => region_hash[loc.name], :latitude => loc.latitude, :longitude => loc.longitude, :country => country)
      end
    end
    article.locations << db_loc
    article.save!
    db_loc.save!
  end
end


def mine_location(csv_loc = 'NGA_CSV.TXT', dbf_loc = 'NGA.dbf', articles_array, country, tolerence_sd)
  puts "Working on " + articles_array.size.to_s + "Articles."
  region_hash = {}

  CSV.foreach(csv_loc, {:headers => true}) do |row|
    region_hash[row[0].downcase] = row[0]
  end

  puts "article input size: " + region_hash.size.to_s

  master_table = DBF::Table.new(dbf_loc)
  puts "Loaded DBF Table"

  #Hash: {lower_name => [long, lat]}
  master_cache_table = {}

  #  IO.foreach(body_loc) do |line|
  articles_array.each do |single_article|
    #Hash: {lower_name => [long, lat, count]}
    puts "\n\nWorking on article name:" + single_article.title
    individual_cache_table = {}
    n_gram = ""
    single_article.text.split.each do |current_word|
      if current_word.capitalize == current_word
        n_gram = n_gram + " " + current_word
        n_gram.strip!
        key = n_gram.downcase
        if region_hash.has_key?(key) #In Memory Hash of the db.
          puts "Found a possible match: " + key
          look_in_region(master_table, master_cache_table, individual_cache_table, region_hash, key) #query and update both caches
          puts "now the ind_cache_table looks like: "
          puts individual_cache_table
        end
      else
        n_gram = "" #Not a Capital letter, start a new n_gram.
      end
    end
    if (individual_cache_table.size != 0)
      determine_relevant_loc_and_save(single_article, individual_cache_table, region_hash, country, tolerence_sd)
    end
  end

  #return nothing, just end it
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
