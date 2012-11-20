Feature: Add users to the website

  As the website admin
  I want to be able to add users
  So that I can increase the worker count on the project


  Background:
    Given the blog is set up with an admin user
    And I am logged in as the administrator

Scenario: add admin user to the website 
  When I go to the add user page
  And I initialize the following user:
  | email         | password  | admin | first_name | last_name | password_confirmation |
  | user1@foo.com | password1 |    1  | tristan    | tao       | password1             |
  And I press "Create"
  Then user should be in the database with these fields:
  | email         | password  | admin | first_name | last_name |
  | user1@foo.com | password1 |    1  | tristan    | tao       |
  And I should be on the users page
  And I should see "User tristan tao has been created!"

Scenario: add user to the website (sad path, not all fields are filled in)
  When I go to the add user page
  And I fill in "user_email" with "user_fail@foo.com"
  And I press "Create"
  Then I should be on the add user page
  And I should see "Error in creating user. Please try again."
  
Scenario: add user to the website (sad path, passwords don't match)
  When I go to the add user page
  And I initialize the following user:
  | email         | password  | admin | first_name | last_name | password_confirmation |
  | user1@foo.com | password1 |    1  | tristan    | tao       | password2             |
  And I press "Create"
  Then I should be on the add user page
  And I should see "Error in creating user. Please try again."

Scenario: add non-admin user to the website 
  When I go to the add user page
  And I initialize the following user:
  | email         | password  | admin | first_name | last_name | password_confirmation |
  | user2@foo.com | password2 |    0  | tristan    | tao       | password2             |
  And I press "Create"
  Then user should be in the database with these fields:
  | email         | password  | admin | first_name | last_name |
  | user2@foo.com | password2 |    0  | tristan    | tao       |
  And I should be on the users page
  And I should see "User tristan tao has been created!"

