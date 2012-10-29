
Then /user should be in the database with these fields$/ do |user_table|
  user_table.hashes.each do |user|

  user = User.find_by_email(user["email"])
  assert(!user.nil?)
  assert_match(user.email, user["email"])
  assert_match(user.password, user["password"])
  assert_match(user.is_admin, user["admin"])
  end
end
  
