require 'spec_helper'

describe Admin::ArticlesController do
  before (:each) do
    @user = User.create!({:first_name => 'Justin', :last_name => 'Chan', :email => 'hellojustinchan@gmail.com', :password => 'derp123', :password_confirmation => 'derp123', :admin => true})
    sign_in @user
    request.env["HTTP_REFERER"] = "where_i_came_from"
  end
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

      @mockArticle = mock("Article", :id => '1', 'title' => "Harry Potter", 'date' => '2/3/2000', 'author' => 'J.K Rowing', 'link' => 'http://www.harrypotter.com', 'text' => 'harry, youre a wizard')

      Admin::UsersController.any_instance.stub(:admin_user?).and_return(true)
      Admin::UsersController.any_instance.stub(:authenticate_user!).and_return(true)

      Admin::ArticlesController.any_instance.stub(:admin_user?).and_return(true)
      Admin::ArticlesController.any_instance.stub(:authenticate_user!).and_return(true)
      Article.stub(:find_by_id).and_return(@mockArticle)
      @mockArticle.stub(:destroy)

      post :delete, {:id => '1'}
    end
    it "should be able to edit an article" do
      mockArticle = mock("Article", :id => '1', 'title' => "Harry Potter", 'date' => '4/15/2001', 'link' => 'harrypotter.com')
      Article.should_receive(:find).and_return(mockArticle)
      post :edit, {:id => '1'}
    end
     it "should be able to edit articles" do
      mockArticle = mock("Article", :id => '1', 'title' => "Harry Potter", 'date' => '12/13/2001', 'link' => 'harrypotter.com')
      Article.should_receive(:find).with('1').and_return(mockArticle)
      mockArticle.should_receive(:title=).with("Title Dos")
      mockArticle.stub(:date=)
      mockArticle.should_receive(:author=).with("justin")
      mockArticle.should_receive(:location=).with(nil)
      mockArticle.should_receive(:link=).with("google.com")
      mockArticle.should_receive(:text=).with(nil)
      mockArticle.should_receive(:save)
      mockArticle.stub(:errors).and_return(mockArticle)
      mockArticle.stub(:full_messages).and_return([])
      post :update, {:id => '1', :article => {:title => "Title Dos", :date => "2/11/1999", :author => "justin", :link => "google.com"}}
    end
  end
  describe "current user is not admin" do
    it "should redirect the user to the homepage" do
      @mockArticle = mock("Article", :id => '1', 'title' => "Harry Potter", 'date' => '1/17/2012', 'author' => 'J.K Rowing', 'link' => 'http://www.harrypotter.com', 'text' => 'harry, youre a wizard')

      Article.stub(:find_by_id).and_return(@mockArticle)
      @mockArticle.stub(:destroy)
      response.should redirect_to "where_i_came_from"
      post :delete, {:id => '1'}
    end
  end

  describe "updating an article" do
    it "should be able to update an article" do
      @mockArticle = mock("Article", :id => '1', :title => "Harry Potter", :date => '8/7/2011', :author => 'J.K Rowing', :link => 'http://www.harrypotter.com', :text => 'harry, youre a wizard')
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
