Given /^the blog contains a source named "(.*)"$/ do |default_name|
  Source.create!(:name => default_name, :home_page => "tristan.com", :quality_rating => 10)
end

Given /^the site contains a source named "(.*)" and with url "(.*)"$/ do |name, url|
  Source.create!(:name => name, :url => url, :home_page => "bogus.com", :quality_rating => "10")
end

Then /source should be in the database with these fields:$/ do |source_table|
  source_table.hashes.each do |source|

  source1 = Source.find_by_name(source[:name])
  assert(!source1.nil?, "Nil source")
  assert_equal(source1.home_page, source[:home_page])
  assert_equal(source1.quality_rating, source[:quality_rating].to_i)
  end
end
