require 'spec_helper'

describe Admin::SourcesController do
  before (:each) do
    @user = User.create!({:first_name => 'Justin', :last_name => 'Chan', :email => 'hellojustinchan@gmail.com', :password => 'derp123', :password_confirmation => 'derp123', :admin => true})
    sign_in @user
    request.env["HTTP_REFERER"] = "where_i_came_from"
  end
  
  describe "getting progress for scraping" do
    it "should return a json of the progress for all sources" do
      source = Source.new(:id=>1, :name => "time", :home_page => "http://www.time.com", :url => "http://www.nytimes.com/services/xml/rss/nyt/HomePage.xml", :quality_rating => 10)
      source.stub(:id).and_return(1)
      source.should_receive(:progress_scrape).and_return("")
      source.should_receive(:progress_classify).and_return("")
      source.should_receive(:progress_location).and_return("")
      source.should_receive(:progress_content).and_return("")
      source.should_receive(:queued).and_return("false")
      Source.stub(:find).and_return(source)
      Source.stub(:all).and_return([source])
      
      Admin::SourcesController.any_instance.stub(:authenticate_user!).and_return(true)
      Admin::UsersController.any_instance.stub(:authenticate_user!).and_return(true)
      
      get "progress", {:id => 1}
    end
  end
end
