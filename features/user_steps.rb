# Justin Chan start

Given /^the blog is set up with an admin user$/ do
	User.create!(:id=>1,:email=>'hellojustinchan@gmail.com', :password=>'derp1234')
	user = User.find_by_id(1)
	user.admin = true
	user.save! 
end

Given /^the blog is set up without an admin user$/ do
	User.create!(:id=>1,:email=>'hellojustinchan@gmail.com', :password=>'derp1234')
end

# Justin Chan end
