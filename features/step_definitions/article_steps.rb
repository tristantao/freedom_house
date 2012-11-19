Given /the following articles exist:$/ do |article_table|
  article_table.hashes.each do |article|
    a = Article.create(:link=>article[:link], :location=>article[:location], :title=>article[:title], :author=>article[:author], :date=>article[:date], :text=>article[:text])
    a.save
  end
end

Then /^there should be at least "(.*)" articles in the database$/ do |number|
  count = Article.count
  number = Integer(number)
  assert(count >= number, "There are only #{count} articles, there should be #{number}")
end
