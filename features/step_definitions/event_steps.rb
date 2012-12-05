Given /^the blog is set up with an event named "(.*)"$/ do |event_name|
  a=Event.create!(:name=> event_name, :country => "Nigeria", :description => "testing the event", :date => DateTime.now)
  a.save!
end
