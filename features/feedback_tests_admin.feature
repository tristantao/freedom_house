Feature: Feedback system so users can complain/admins can respond
 
  As a user
  I want to be able to complain about the website
  So that the website can be constantly improving

Background: Admin user time
  Given the blog is set up with an admin user
  And the blog is also set up with a non-admin user
  And I am logged in as the administrator
  And I am on the admin feedback page


Scenario: Shows the author of the feedback
  When I press "Create New Feedback"
  And I initialize the following feedback:
  | title        | description                | rating |
  | Title Uno    | I am a derp. Help please   |   5    |
  And I press "Create"
  And I cheat and magically assign this feedback to Bugs Bunny
  And I follow "Title Uno"
  Then I should see "Bugs Bunny"
  And I should not see "Justin Chan"

Scenario: Should see user who last updated / admin can see all feedback
  When I press "Create New Feedback"
  And I initialize the following feedback:
  | title        | description                | rating |
  | Title Uno    | I am a derp. Help please   |   5    |
  And I press "Create"
  And I cheat and magically assign this feedback to Bugs Bunny
  And I am on the admin feedback page
  And I follow "Title Uno"
  And I press "New Comment"
  And I fill in "response_body" with "THIS IS A COMMENT."
  And I press "Create"
  And I am on the admin feedback page
  Then I should see "Justin Chan"

Scenario: Resolve comments
  When I press "Create New Feedback"
  And I initialize the following feedback:
  | title        | description                | rating |
  | Title Uno    | I am a derp. Help please   |   5    |
  And I press "Create"
  And I cheat and magically assign this feedback to Bugs Bunny
  And I am on the admin feedback page
  And I follow "Resolve"
  Then there should be no active feedback




