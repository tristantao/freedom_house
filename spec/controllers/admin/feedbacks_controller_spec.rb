require 'spec_helper'

describe Admin::FeedbacksController do
  before (:each) do
    @user = User.create!({:first_name => 'Justin', :last_name => 'Chan', :email => 'hellojustinchan@gmail.com', :password => 'derp123', :password_confirmation => 'derp123', :admin => true})
    sign_in @user
  end
  describe "manipulating shit" do
    it "should be able to resolve feedback" do
      mockFeedback = mock("Feedback", :id => '1', :title => "Title Uno", :description => 'I am a derp.', :active => 'true')
      Feedback.should_receive(:find_by_id).with('1').and_return(mockFeedback)
      mockFeedback.should_receive(:active=).with(false)
      mockFeedback.stub(:save)

      post :resolve, {:id => 1}
    end
    it "should be able to delete feedback" do
      mockFeedback = mock("Feedback", :id => '1', :title => "Title Uno", :description => 'I am a derp.', :active => 'true')
      Feedback.should_receive(:find_by_id).with('1').and_return(mockFeedback)
      mockFeedback.should_receive(:delete)
      mockFeedback.stub(:save)

      post :delete, {:id => '1'}
    end
    it "should be able to add feedback" do
      mockFeedback = mock("Feedback", :id => '1', :title => "Title Uno", :description => 'I am a derp.', :active => 'true')
      Feedback.should_receive(:create).and_return(mockFeedback)
      mockFeedback.should_receive(:user=).and_return(@user)
      mockFeedback.should_receive(:last_updated_user=).and_return(@user.name)
      mockFeedback.stub(:save)
      mockFeedback.stub(:errors).and_return(mockFeedback)
      mockFeedback.stub(:full_messages).and_return([])
      post :new, {:feedback => {:title => "Title Uno", :description => "I am a derp.", :rating => 5}}
    end
    it "should be able to edit feedback" do
      mockFeedback = mock("Feedback", :id => '1', :title => "Title Uno", :description => 'I am a derp.', :active => 'true')
      Feedback.should_receive(:find_by_id).with('1').and_return(mockFeedback)
      mockFeedback.should_receive(:title=).with("Title Dos")
      mockFeedback.should_receive(:description=).with("I am not a derp.")
      mockFeedback.should_receive(:rating=).with("4")
      mockFeedback.should_receive(:active=).with(true)
      mockFeedback.should_receive(:save)
      mockFeedback.stub(:errors).and_return(mockFeedback)
      mockFeedback.stub(:full_messages).and_return([])
      post :update, {:id => '1', :feedback => {:title => "Title Dos", :description => "I am not a derp.", :rating => "4", :active => true}}
    end
    it "should view things" do
      mockFeedback = mock("Feedback", :id => '1', :title => "Title Uno", :description => 'I am a derp.', :active => 'true')
      Feedback.should_receive(:find_by_id).with('1').and_return(mockFeedback)
      post :view, {:id => '1'}
    end
    it "should edit things" do
      mockFeedback = mock("Feedback", :id => '1', :title => "Title Uno", :description => 'I am a derp.', :active => 'true')
      Feedback.should_receive(:find_by_id).with('1').and_return(mockFeedback)
      post :edit, {:id => '1'}
    end
  end



end
