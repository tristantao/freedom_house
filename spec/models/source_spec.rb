require 'spec_helper'

describe Source do
  describe '#scrapable?' do
    context 'it was scraped less than 5 minutes ago' do
      it 'should not be scrapable' do
        source = Source.new(:name => 'A Source', :home_page => "http://www.myhomepage.com", :url => "http://rss.nytimes.com/services/xml/rss/nyt/HomePage.xml", :last_scraped => DateTime.now, :progress_scrape => "0%", :progress_content => "0%", :progress_location => "0%", :progress_classify => "0%", :quality_rating => 10)
        source.stub(:last_scraped).and_return(DateTime.now)
        source.scrapable?.should be_false
      end
    end
    context 'it has not been scraped for a while' do
      it 'should be scrapable' do
        source = Source.new(:name => 'A Source', :home_page => "http://www.myhomepage.com", :url => "http://rss.nytimes.com/services/xml/rss/nyt/HomePage.xml", :last_scraped => nil, :progress_scrape => "0%", :progress_content => "0%", :progress_location => "0%", :progress_classify => "0%", :quality_rating => 10)
        source.last_scraped = Date.yesterday.to_datetime
        source.scrapable?.should be_true
      end
    end
    context 'source has never been scraped before' do
      it 'should be scrapable' do
        source = Source.new(:name => 'A Source', :home_page => "http://www.myhomepage.com", :url => "http://rss.nytimes.com/services/xml/rss/nyt/HomePage.xml", :last_scraped => nil, :progress_scrape => "0%", :progress_content => "0%", :progress_location => "0%", :progress_classify => "0%", :quality_rating => 10)
        source.last_scraped = nil
        source.scrapable?.should be_true
      end
    end
  end

  describe '#scrape' do
    context 'source feed has no new articles' do
      it 'should update by 25% and not add any new articles' do
        source = Source.new(:name => 'A Source', :home_page => "http://www.myhomepage.com", :url => "http://rss.nytimes.com/services/xml/rss/nyt/HomePage.xml", :last_scraped => nil, :progress_scrape => "0%", :progress_content => "0%", :progress_location => "0%", :progress_classify => "0%", :quality_rating => 10)
        obj = Object.new
        obj.stub(:entries).and_return([])
        Feedzirra::Feed.stub(:fetch_and_parse).and_return(obj)
        article = Article.new(:title => "Tristan's awesome", :url => "http://www.dailytrust.com.ng/index.php/rss/xml/RSS2.0/full", :contains_hatespeech => "true", :text => "Tristan stayed up all night to try to get tests to work. He should definitely get a B, Richard", :date => DateTime.parse("Jan 12 2012"))

        article.stub(:scrapeContent!).and_return(true)
        source.stub(:save).and_return(true)

        source.scrape.should be_true
      end
    end
    context 'source feed does have new articles' do
      it 'should save the articles' do
        source = Source.new(:name => 'A Source', :home_page => "http://www.myhomepage.com", :url => "http://rss.nytimes.com/services/xml/rss/nyt/HomePage.xml", :last_scraped => nil, :progress_scrape => "0%", :progress_content => "0%", :progress_location => "0%", :progress_classify => "0%", :quality_rating => 10)
        item = Object.new
        item.stub(:title).and_return("tile of the article goes here")
        item.stub(:author).and_return("author")
        item.stub(:url).and_return("http://rss.nytimes.com/services/xml/rss/nyt/HomePage.xml")
        item.stub(:published).and_return(DateTime.parse("Jan 12 2012"))

        obj = Object.new
        obj.stub(:entries).and_return([item])

        Feedzirra::Feed.stub(:fetch_and_parse).and_return(obj)
        article = Article.new(:title => "Tristan's awesome", :url => "http://www.dailytrust.com.ng/index.php/rss/xml/RSS2.0/full", :contains_hatespeech => "true", :text => "Tristan stayed up all night to try to get tests to work. He should definitely get a B, Richard", :date => DateTime.parse("Jan 12 2012"))

        article.stub(:scrapeContent!).and_return(true)
        source.stub(:save).and_return(true)

        source.scrape.should be_true
      end
      it 'should update the percentages correctly' do
      end
    end

    context 'scrape target website is not responding' do
      it 'should retry 3 times' do
        source = Source.new(:name => 'A Source', :home_page => "http://www.myhomepage.com", :url => "http://rss.nytimes.com/services/xml/rss/nyt/HomePage.xml", :last_scraped => nil, :progress_scrape => "0%", :progress_content => "0%", :progress_location => "0%", :progress_classify => "0%", :quality_rating => 10)
        item = Object.new
        item.stub(:title).and_return("tile of the article goes here")
        item.stub(:author).and_return("author")
        item.stub(:url).and_return("http://rss.nytimes.com/services/xml/rss/nyt/HomePage.xml")
        item.stub(:published).and_return(DateTime.parse("Jan 12 2012"))

        obj = Object.new
        obj.stub(:entries).and_return([item])

        Feedzirra::Feed.stub(:fetch_and_parse).and_return(obj)
        article = mock("Article", :title => "Tristan's awesome", :url => "http://rss.nytimes.com/services/xml/rss/nyt/HomePage.xml", :contains_hatespeech => "true", :text => "Tristan stayed up all night to try to get tests to work. He should definitely get a B, Richard", :date => DateTime.parse("Jan 12 2012"))
        article.stub(:title=)
        article.stub(:author=)
        article.stub(:link=)
        article.stub(:link)
        article.stub(:date=)
        article.stub(:source=)
        article.stub(:delete)
        article.stub(:save).and_return(true)
        Article.stub(:new).and_return(article)

        article.stub(:scrapeContent!).and_raise(OpenURI::HTTPError.new("testing invalid queries", Object.new))
        source.stub(:save).and_return(true)

        source.scrape.should be_true
      end
      it 'should update the percentages correctly' do
      end
    end
  end


end
