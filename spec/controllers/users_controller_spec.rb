require 'spec_helper'

describe Admin::UsersController do
  describe "editing users" do
    it "should be able to edit existing users" do
      @test_user = User.new(:id =>1, :email => "tristan@gmail.com", :admin => true, :first_name=> 'Tristan', :last_name =>'Tao')

      User.stub(:find).with(1).and_return(@test_user)
      @test_user.stub(:email=).with("chris@gmail.com")
      @test_user.stub(:first_name=).with("Chris")
      @test_user.stub(:last_name=).with("Balcells")
      @test_user.stub(:admin=).with(true)
      @test_user.stub(:save).and_return(true)
      @test_user.stub(:errors).and_return(@test_user)
      @test_user.stub(:full_messages).and_return([])

      Admin::UsersController.any_instance.stub(:admin_user?).and_return(true)
      put :update, {:id => 1, :user => {:email => "chris@gmail.com", :first_name => 'Chris', :last_name => 'Balcells', :admin => true}}
    end
  end

end
