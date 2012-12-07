Given /^the blog is set up with an event named "(.*)"$/ do |event_name|
  a=Event.create!(:name=> event_name, :country => "Nigeria", :description => "testing the event", :date => DateTime.now)
  a.save!
end

Then /^I should see events map$/ do 
  page.has_xpath?("//div[@class='gmaps4rails_map']") 
end 
