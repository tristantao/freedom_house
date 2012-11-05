require 'spec_helper'

describe UserController do
=begin
  describe "editing a user" do
    it "non-admin should be able to edit themselves" do

      test_user = mock("User", :id =>'1', :email => "tristan@gmail.com", :admin => false, :first_name=> 'Tristan', :last_name =>'Tao')
      test_user.should_receive(:update_with_password).with({'email' => "chris@gmail.com", 'first_name' => 'Chris', 'last_name' => 'Balcells', 'admin' => false})

      test_user.stub(:save)
      User.should_receive(:find).with("1").and_return(test_user)
      test_user.should_receive(:email=).with("chris@gmail.com")
      test_user.should_receive(:first_name=).with("Chris")
      test_user.should_receive(:last_name=).with("Balcells")
      test_user.should_receive(:admin=).with(false)
      test_user.should_receive(:save)

      #Admin::UsersController.any_instance.stub(:admin_user?).and_return(true)
      post :update, {:id => '1', "user" => {'email' => "chris@gmail.com", 'first_name' => 'Chris', 'last_name' => 'Balcells', 'admin' => false}}
    end
  end
=end
end
