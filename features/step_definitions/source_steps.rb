Given /^the blog contains a source named "(.*)"$/ do |default_name|
  Source.create!(:name => default_name, :home_page => "tristan.com", :quality_rating => 10)
end
