require 'spec_helper'

describe Admin::ArticlesController do
  before (:each) do
    @user = User.create!({:first_name => 'Justin', :last_name => 'Chan', :email => 'hellojustinchan@gmail.com', :password => 'derp123', :password_confirmation => 'derp123', :admin => true})
    sign_in @user
  end
  describe "adding new articles" do
    it "should be able to add articles" do
      mockArticle = mock("Article", :id => '1', 'title' => "Harry Potter", 'date' => 'Jan 1, 2011', 'link' => 'harrypotter.com')
      Article.should_receive(:create).and_return(mockArticle)
      mockArticle.stub(:save)
      mockArticle.stub(:locations).and_return([])
      mockArticle.stub(:errors).and_return(mockArticle)
      mockArticle.stub(:full_messages).and_return([])

      post :new, {"article" => {'title' => "Harry Potter", 'date' => 'Jan 1, 2011', 'link' => 'harrypotter.com'}}
    end
  end

  describe "deleting an article" do
    it "should be able to delete an article" do
      mockArticle = mock("Article", :id => '1', 'title' => "Harry Potter", 'date' => 'Jan 1, 2011', 'link' => 'harrypotter.com')
      Article.should_receive(:find_by_id).and_return(mockArticle)
      mockArticle.should_receive(:destroy)

      post :delete, {:id => '1'}
    end
    it "should be able to edit an article" do
      mockArticle = mock("Article", :id => '1', 'title' => "Harry Potter", 'date' => 'Jan 1, 2011', 'link' => 'harrypotter.com')
      Article.should_receive(:find).and_return(mockArticle)
      post :edit, {:id => '1'}
    end
     it "should be able to edit articles" do
      mockArticle = mock("Article", :id => '1', 'title' => "Harry Potter", 'date' => 'Jan 1, 2011', 'link' => 'harrypotter.com')
      Article.should_receive(:find).with('1').and_return(mockArticle)
      mockArticle.should_receive(:title=).with("Title Dos")
      mockArticle.should_receive(:date=).with("Oct 29 2012")
      mockArticle.should_receive(:author=).with("justin")
      mockArticle.should_receive(:location=).with(nil)
      mockArticle.should_receive(:link=).with("google.com")
      mockArticle.should_receive(:text=).with(nil)
      mockArticle.should_receive(:save)
      mockArticle.stub(:errors).and_return(mockArticle)
      mockArticle.stub(:full_messages).and_return([])
      post :update, {:id => '1', :article => {:title => "Title Dos", :date => "Oct 29 2012", :author => "justin", :link => "google.com"}}
    end
  end

end
