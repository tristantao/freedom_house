
Then /user should be in the database with these fields:$/ do |user_table|
  user_table.hashes.each do |user|

  user1 = User.find_by_email(user[:email])
  assert(!user1.nil?, "Nil user")
  assert_equal(user1.email, user[:email])
  #assert_equal(user1.password, user[:password])
  assert_equal(user1.admin, booltime(user[:admin]))
  end
end

And /^I initialize the following user:$/ do |user_info|
  user_info.hashes.each do |info|
  is_admin = booltime2(info[:admin])
  step %{I fill in "user_email" with "#{info[:email]}"}
  step %{I fill in "user_password" with "#{info[:password]}"}
  step %{I fill in "user_password_confirmation" with "#{info[:password_confirmation]}"}
  step %{I fill in "user_first_name" with "#{info[:first_name]}"}
  step %{I fill in "user_last_name" with "#{info[:last_name]}"}
  step %{I select "#{is_admin}" from "user_admin"}
	end
end

Then /source should be in the database with these fields:$/ do |source_table|
	source_table.hashes.each do |source|
	
	source1 = Source.find_by_name(source[:name])
	assert(!source1.nil?, "Nil source")
	assert_equal(source1.home_page, source[:home_page])
	assert_equal(source1.quality_rating, source[:quality_rating].to_i)
	end
end

def booltime(b)
	if b == "1"
		return true
	else
		return false
	end
end

def booltime2(b)
  if b == "1"
    return "Yes"
  else
    return "No"
  end
end

#EXTRA JUSTIN STUFF
Then /^(?:|I )should honestly be on the source page for "(.+)"$/ do |page_name|
  linkgiventitle = Article.find_by_title(page_name).link
  if current_path.respond_to? :should
    current_url == linkgiventitle
  else
    assert_equal linkgiventitle, current_url
  end
end

