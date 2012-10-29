# Justin Chan start

Given /^the blog is set up with an admin user$/ do
  User.create!(:id=>1,:email=>'hellojustinchan@gmail.com', :password=>'derp1234', :first_name => 'ustin', :last_name => 'Chan')
  user = User.find_by_id(1)
  user.admin = true
  user.save!
end

Given /^the blog is set up without an admin user$/ do
  User.create!(:id=>1,:email=>'hellojustinchan@gmail.com', :password=>'derp1234', :first_name => 'Justin', :last_name => 'Chan')
end

# Justin Chan end

Given /^I am logged in as the administrator$/ do
  step %{I am on the home page}
  step %{I fill in "Email" with "hellojustinchan@gmail.com"}
  step %{I fill in "Password" with "derp1234"}
  step %{I press "Sign in"}
  step %{I am on the home page}
end
