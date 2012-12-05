require 'spec_helper'

describe Article do
  it 'test scrape all' do
    article = Article.new
    article.stub(:scrapeContent!)
    article.should_receive(:mine_location).with('db/dbf/NGA_CSV.TXT', 'db/dbf/NGA.dbf', [article], "Nigeria", 1, nil)
    classify = mock("Classifier")
    Classifier.stub(:all).and_return([classify, classify, classify])
    classify.stub(:on_off).and_return(true)
    classify.should_receive(:classify).with([article], nil).and_return(true)
    article.scrapeAll!
  end

end
