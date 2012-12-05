require 'spec_helper'

describe Admin::ArticlesController do
  describe "adding new articles" do
    it "should be able to add articles" do
      @mockArticle = mock("Article", :id => '1', 'title' => "Harry Potter", 'date' => 'Jan 1, 2011', 'author' => 'J.K Rowing', 'link' => 'harrypotter.com', 'text' => 'harry, youre a wizard')
      Article.stub(:create).and_return(@mockArticle)
      @mockArticle.stub(:save)
      @mockArticle.stub(:locations).and_return([])

      post :new, :article => {:title => "Harry Potter", :date => 'Jan 1, 2011', :author => 'J.K Rowing', :link => 'harrypotter.com', :text => 'harry, youre a wizard'}
    end
  end

  describe "deleting an article" do
    it "should be able to delete an article" do
      @mockArticle = mock("Article", :id => '1', 'title' => "Harry Potter", 'date' => 'Jan 1, 2011', 'author' => 'J.K Rowing', 'link' => 'harrypotter.com', 'text' => 'harry, youre a wizard')
      Article.stub(:find_by_id).and_return(@mockArticle)
      @mockArticle.stub(:delete)
      post :delete, {:id => '1'}
    end
  end

end
