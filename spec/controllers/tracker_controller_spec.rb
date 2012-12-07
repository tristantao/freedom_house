require 'spec_helper'

describe TrackerController do
  describe "displays the home page" do
    it "should display the time graph (0,0) input" do
      @mockArticle = Article.new(:id => 1, :title => "Harry Potter", :date => '11/12/2011', :author => 'J.K Rowing', :link => 'http://www.harrypotter.com', :text => 'harry, youre a wizard')
      @mockArticle2 = Article.new(:id => 2, :title => "Harry Potter2", :date => '11/13/2011', :author => 'J.K Rowing', :link => 'http://www.harrypotter2.com', :text => 'harry, youre a wizard2')
      Article.stub(:find).and_return([@mockArticle, @mockArticle2])
      Article.stub(:all).and_return([@mockArticle, @mockArticle2])
      TrackerController.any_instance.stub(:authenticate_user?).and_return(true)
      Admin::UsersController.any_instance.stub(:authenticate_user!).and_return(true)
      get :viewGraph
    end
  end

  describe "displays the home page" do
    it "should display the time graph input" do
      @mockArticle = Article.new(:id => 1, :title => "Harry Potter", :date => DateTime.now.to_date, :author => 'J.K Rowing', :link => 'http://www.harrypotter.com', :text => 'harry, youre a wizard')
      @mockArticle2 = Article.new(:id => 2, :title => "Harry Potter2", :date => DateTime.now.to_date - 1, :author => 'J.K Rowing', :link => 'http://www.harrypotter2.com', :text => 'harry, youre a wizard2')

      Article.stub(:find).and_return([@mockArticle, @mockArticle2])
      Article.stub(:all).and_return([@mockArticle, @mockArticle2])
      TrackerController.any_instance.stub(:authenticate_user!).and_return(true)
      Admin::UsersController.any_instance.stub(:authenticate_user!).and_return(true)
      get :viewGraph, {:start => '25-12-1990', :end => '25-12-1992'}
    end
  end
  
  describe "viewArticle method" do
    it "should return a json of an article" do
      @mockArticle = mock("Article", :id => '1', :title => "Harry Potter", :date => '8/7/2011', :author => 'J.K Rowing', :link => 'http://www.harrypotter.com', :text => 'harry, youre a wizard')
      Article.stub(:find_by_id).and_return(@mockArticle)
      @mockArticle.stub(:save).and_return(true)
      @mockArticle.stub(:id=).and_return(true)
      @mockArticle.stub(:link=).and_return(true)
      @mockArticle.stub(:title=).and_return(true)
      @mockArticle.stub(:date=).and_return(true)
      @mockArticle.stub(:author=).and_return(true)
      @mockArticle.stub(:location=).and_return(true)
      @mockArticle.stub(:text=).and_return(true)
      @mockArticle.stub(:hateArray).and_return([])
      @mockArticle.stub(:to_json).and_return("")
      TrackerController.any_instance.stub(:authenticate_user!).and_return(true)
      Admin::UsersController.any_instance.stub(:authenticate_user!).and_return(true)
      TrackerController.any_instance.stub(:render).and_return("")
      
      get :viewArticle, {:articleID => '1'}
    end
  end
end
