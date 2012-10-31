
Then /user should be in the database with these fields:$/ do |user_table|
  user_table.hashes.each do |user|

  user1 = User.find_by_email(user[:email])
  assert(!user1.nil?, "Nil user")
  assert_equal(user1.email, user[:email])
  #assert_equal(user1.password, user[:password])
  assert_equal(user1.admin, booltime(user[:admin]))
  end
end

def booltime(b)
	if b == "1"
		return true
	else
		return false
	end
end

