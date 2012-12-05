Given /^the webscraper extracted an article from a source$/ do
  Article.create(:title => "Nigera Conflict", :date => "11/11/2012", :source_id => "1", 
                  :admin_verified => true, :contains_hatespeech => true, :author => "Felix Li", :link => "http://www.google.com", :text => "filler")
  HateSpeech.create(:speaker => "Balcells Tao", :body => "filler", :article_id => 1) 
end

Given /^the machine learner processed that article$/ do
  #machine.process(article id => 1)
end
