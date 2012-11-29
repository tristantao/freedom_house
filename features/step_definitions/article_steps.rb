Given /the following articles exist:$/ do |article_table|
  article_table.hashes.each do |article|
    a = Article.new(:link=>article[:link], :title=>article[:title], :author=>article[:author], :date=>article[:date], :text=>article[:text])
    loc = Location.create(:name => article[:location], :latitude => 0.000, :longitude => 0.000)
    a.locations << loc
    a.save
  end
end

Then /^there should be at least "(.*)" articles in the database$/ do |number|
  count = Article.count
  number = Integer(number)
  assert(count >= number, "There are only #{count} articles, there should be #{number}")
end
