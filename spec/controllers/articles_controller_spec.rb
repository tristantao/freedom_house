require 'spec_helper'

describe Admin::ArticlesController do
  describe "adding new articles" do
    it "should be able to add articles" do
      @mockArticle = mock("Article", :id => 1, :title => "Harry Potter", :date => '11/12/2011', :author => 'J.K Rowing', :link => 'http://www.harrypotter.com', :text => 'harry, youre a wizard')
      Article.stub(:create).and_return(@mockArticle)
      @mockArticle.stub(:save).and_return(true)
      @mockArticle.stub(:scrapeAll!).and_return(true)
      Admin::UsersController.any_instance.stub(:admin_user?).and_return(true)
      Admin::UsersController.any_instance.stub(:authenticate_user!).and_return(true)

      Admin::ArticlesController.any_instance.stub(:admin_user?).and_return(true)
      Admin::ArticlesController.any_instance.stub(:authenticate_user!).and_return(true)

      post :new, {:article => {:title => "Harry Potter", :date => '1/1/2011', :author => 'J.K Rowing', :link => 'http://www.harrypotter.com', :text => 'harry, youre a wizard'}}
    end
  end

  describe "deleting an article" do
    it "should be able to delete an article" do
      @mockArticle = mock("Article", :id => '1', 'title' => "Harry Potter", 'date' => 'Jan 1, 2011', 'author' => 'J.K Rowing', 'link' => 'http://www.harrypotter.com', 'text' => 'harry, youre a wizard')

      Admin::UsersController.any_instance.stub(:admin_user?).and_return(true)
      Admin::UsersController.any_instance.stub(:authenticate_user!).and_return(true)

      Admin::ArticlesController.any_instance.stub(:admin_user?).and_return(true)
      Admin::ArticlesController.any_instance.stub(:authenticate_user!).and_return(true)
      Article.stub(:find_by_id).and_return(@mockArticle)
      @mockArticle.stub(:destroy)
      post :delete, {:id => '1'}
    end
  end
  describe "current user is not admin" do
    it "should redirect the user to the homepage" do
      @mockArticle = mock("Article", :id => '1', 'title' => "Harry Potter", 'date' => 'Jan 1, 2011', 'author' => 'J.K Rowing', 'link' => 'http://www.harrypotter.com', 'text' => 'harry, youre a wizard')

      Article.stub(:find_by_id).and_return(@mockArticle)
      @mockArticle.stub(:destroy)
      post :delete, {:id => '1'}
    end
  end

  describe "updating an article" do
    it "should be able to update an article" do
      @mockArticle = mock("Article", :id => '1', :title => "Harry Potter", :date => '11/12/2011', :author => 'J.K Rowing', :link => 'http://www.harrypotter.com', :text => 'harry, youre a wizard')
      Article.stub(:find).and_return(@mockArticle)
      @mockArticle.stub(:save).and_return(true)
      @mockArticle.stub(:id=).and_return(true)
      @mockArticle.stub(:link=).and_return(true)
      @mockArticle.stub(:title=).and_return(true)
      @mockArticle.stub(:date=).and_return(true)
      @mockArticle.stub(:author=).and_return(true)
      @mockArticle.stub(:location=).and_return(true)
      @mockArticle.stub(:text=).and_return(true)

      Admin::UsersController.any_instance.stub(:admin_user?).and_return(true)
      Admin::UsersController.any_instance.stub(:authenticate_user!).and_return(true)

      Admin::ArticlesController.any_instance.stub(:admin_user?).and_return(true)
      Admin::ArticlesController.any_instance.stub(:authenticate_user!).and_return(true)

      post :update, {:article => {:id => '1', :title => "Harry Potter", :date => '1/1/2011', :author => 'J.K Rowing', :link => 'http://www.harrypotter.com', :text => 'harry, youre a wizard'}}
    end
  end
end
