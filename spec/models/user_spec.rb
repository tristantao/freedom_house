require 'spec_helper'

describe User do
  it 'should have admin_privileges if user is admin' do
    user = User.new
    user.admin = true
    user.admin_privileges.should == "Yes"
  end
  it 'should not have admin_privileges if user is not admin' do
    user = User.new
    user.admin = false
    user.admin_privileges.should == "No"
  end
  it 'has a full name with a first name and last name' do
    user = User.new
    user.stub(:first_name).and_return("freddy")
    user.stub(:last_name).and_return("so franky")
    user.name.should == "freddy so franky"
  end
end
