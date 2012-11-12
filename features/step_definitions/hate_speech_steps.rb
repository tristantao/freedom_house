Given /^the webscraper extracted an article from a source$/ do
  Article.create!(:id => 1, :title => "Nigera Conflict", :location => "Nigeria", :date => "Nov 11, 2012", :author => "Felix Li", :link => "conflict.com", :text => "sample")
  HateSpeech.create!(:speaker => "Balcells Tao", :body => "violence between Christians and Muslims", :article => "1") 
end

Given /^the machine learner processed that article$/ do
  #machine.process(article id => 1)
end
