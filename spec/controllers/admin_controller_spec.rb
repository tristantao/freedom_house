require 'spec_helper'

describe AdminController do
  describe "editing users" do
    it "should be able to edit existing users" do
      test_user = mock("User", :id =>'1', :email => "tristan.sad@gmail.com", :admin => true)
      User.should_receive(:find).with("1").and_return(test_user)
      test_user.should_receive(:email=).with("tristan.sad@gmail.com")
      test_user.stub(:admin=)
      test_user.stub(:save)
      AdminController.any_instance.stub(:admin_user?).and_return(true)
      post :update, {:id => '1', "user" => {'email' => "tristan.sad@gmail.com", 'admin' => 'true'}}
    end 
  end
end
