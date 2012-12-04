require 'spec_helper'

describe Admin::FeedbacksController do
  describe "adding new feedback" do
    it "should be able to add feedback" do
      mockFeedback = mock("Feedback", :id => '1', :title => "Title Uno", :description => 'I am a derp.', :active => 'true')
      Feedback.should_receive(:find_by_id).with('1').and_return(mockFeedback)
      mockFeedback.stub(:save)

      post :resolve, {:id => '1'}
    end
  end

 

end
