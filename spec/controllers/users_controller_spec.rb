require 'spec_helper'

describe Admin::UsersController do
  before (:each) do
    @user = User.create!({:first_name => 'Justin', :last_name => 'Chan', :email => 'hellojustinchan@gmail.com', :password => 'derp123', :password_confirmation => 'derp123', :admin => true})
    sign_in @user
  end
  describe "editing users" do
    it "should be able to edit existing users" do
      test_user = mock("User", :id =>'1', :email => "tristan@gmail.com", :admin => true, :first_name=> 'Tristan', :last_name =>'Tao')
      test_user.stub(:save)
      User.should_receive(:find).with("1").and_return(test_user)
      test_user.should_receive(:email=).with("chris@gmail.com")
      test_user.should_receive(:first_name=).with("Chris")
      test_user.should_receive(:last_name=).with("Balcells")
      test_user.should_receive(:admin=).with(true)
      test_user.should_receive(:save)
      test_user.stub(:errors).and_return(test_user)
      test_user.stub(:full_messages).and_return([])

      Admin::UsersController.any_instance.stub(:admin_user?).and_return(true)
      post :update, {:id => '1', "user" => {'email' => "chris@gmail.com", 'first_name' => 'Chris', 'last_name' => 'Balcells', 'admin' => true}}
    end
    it "should be able to add users" do
      test_user = mock("User", :id =>'1', :email => "hellojustinchan@gmail.com", :admin => true, :first_name=> 'Justin', :last_name =>'Chan', :password => 'derp123', :password_confirmation => 'derp123')
      User.should_receive(:create).and_return(test_user)
      test_user.should_receive(:admin=).and_return(true)
      test_user.stub(:save)
      test_user.stub(:errors).and_return(test_user)
      test_user.stub(:full_messages).and_return([])
      post :new, :user => {:first_name => 'Justin', :last_name => 'Chan', :email => 'hellojustinchan@gmail.com', :password => 'derp123', :password_confirmation => 'derp123', :admin => true}
    end
    it "should delete users" do 
      test_user = mock("User", :id =>'1', :email => "hellojustinchan@gmail.com", :admin => true, :first_name=> 'Justin', :last_name =>'Chan', :password => 'derp123', :password_confirmation => 'derp123')
      User.should_receive(:find_by_id).with('1').and_return(test_user)
      test_user.stub(:first_name).and_return('Justin')
      test_user.stub(:last_name).and_return('Chan')
      test_user.should_receive(:delete)
      post :delete, :id => '1'
    end
    it "should edit users" do 
      test_user = mock("User", :id =>'1', :email => "hellojustinchan@gmail.com", :admin => true, :first_name=> 'Justin', :last_name =>'Chan', :password => 'derp123', :password_confirmation => 'derp123')
      User.should_receive(:find).with('1').and_return(test_user)
      post :edit, :id => '1'
    end
  end

end
