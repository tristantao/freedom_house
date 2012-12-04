Feature: Feedback system so users can complain/admins can respond
 
  As a user
  I want to be able to complain about the website
  So that the website can be constantly improving

Background: Non-admin user is logged in
  
  Given the blog is set up without an admin user
  And I am logged in as a regular user
  And I am on the non-admin feedback page

Scenario: Nothing at first
  Then I should not see "THIS IS A COMMENT."

Scenario: Creating a feedback
  When I press "Create New Feedback"
  And I initialize the following feedback:
  | title        | description                | rating |
  | Title Uno    | I am a derp. Help please   |   5    |
  And I press "Create"
  Then I should be on the non-admin feedback page
  And feedback should be in the database with these fields:
  | title        | description                | rating | user        |
  |   Title Uno  | I am a derp. Help please   |   5    | Justin Chan |
  And I should see "Thank you for submitting website feedback. An admin will respond as soon as possible."

Scenario: Creating a feedback -- SAD PATH
  When I press "Create New Feedback"
  And I initialize the following feedback:
  | title        | description                | rating |
  |              | I am a derp. Help please   |   5    |
  And I press "Create"
  Then I should see "Title can't be blank."

Scenario: Creating a comment
  When I press "Create New Feedback"
  And I initialize the following feedback:
  | title        | description                | rating |
  | Title Uno    | I am a derp. Help please   |   5    |
  And I press "Create"
  And I follow "Title Uno"
  And I press "New Comment"
  And I fill in "response_body" with "THIS IS A COMMENT."
  And I press "Create"
  Then I should see "THIS IS A COMMENT"
  And I should see "Comment submitted."

Scenario: Creating a comment -- SAD PATH
  When I press "Create New Feedback"
  And I initialize the following feedback:
  | title        | description                | rating |
  | Title Uno    | I am a derp. Help please   |   5    |
  And I press "Create"
  And I follow "Title Uno"
  And I press "New Comment"
  And I press "Create"
  Then I should see "Body can't be blank."

Scenario: Users can only see their feedback
 When the blog is now also set up with an admin user by the name of Michael Scott
 And I press "Create New Feedback"
 And I initialize the following feedback:
 | title        | description                | rating |
 | Title Uno    | I am a derp. Help please   |   5    |
 And I press "Create"
 And I cheat and magically assign this feedback to Michael Scott
 And I am on the non-admin feedback page
 Then I should not see "Title Uno"
  




