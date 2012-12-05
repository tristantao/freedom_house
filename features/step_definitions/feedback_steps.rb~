And /^I initialize the following feedback:$/ do |feedback_info|
  feedback_info.hashes.each do |info|
  step %{I fill in "feedback_title" with "#{info[:title]}"}
  step %{I fill in "feedback_description" with "#{info[:description]}"}
  step %{I select "#{info[:rating]}" from "feedback_rating"}
  end
end

Then /feedback should be in the database with these fields:$/ do |feedback_table|
  feedback_table.hashes.each do |feedback|

  f = Feedback.find_by_title(feedback[:title])
  assert_equal(f.title, feedback[:title])
  assert_equal(f.description, feedback[:description])
  assert_equal(f.rating, feedback[:rating].to_f)
  assert_equal(f.user.name, feedback[:user])
  end
end

And /^I cheat and magically assign this feedback to Bugs Bunny$/ do 
  f = Feedback.find_by_title("Title Uno")
  f.user = User.find_by_first_name("Bugs")
  f.save
end

And /^there should be no active feedback$/ do
  assert_nil(Feedback.find_by_active(true))
end

And /^I cheat and magically assign this feedback to Michael Scott$/ do 
  f = Feedback.find_by_title("Title Uno")
  f.user = User.find_by_first_name("Michael")
  f.save
end
 



