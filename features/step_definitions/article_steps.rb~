Given /the following articles exist:$/ do |article_table|
	article_table.hashes.each do |article|
		a = Article.create(:link=>article[:link], :location=>article[:location], :title=>article[:title], :author=>article[:author], :date=>article[:date])
		a.save
	end
end
