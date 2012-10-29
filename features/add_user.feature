Feature: Add users to the website

  As the website admin
  So that I can increase the worker count on the project
  I want to be able to add users

  Background:
    Given the blog is set up with an admin user
    And I am logged in as the administrator

Scenario: add admin user to the website (happy path)
  When I go to the add user page
  And I fill in "user_email" with "user1@foo.com"
  And I fill in "user_password" with "password1"
  And I fill in "user_password_confirmation" with "password1"
  And I fill in "user_first_name" with "tristan"
  And I fill in "user_last_name" with "tao"
  And I select "Yes" from "user_admin"
  And I press "Sign up"
  Then user should be in the database with these fields:
  | email         | password  | admin | first_name | last_name |
  | user1@foo.com | password1 |    1  | tristan    | tao       |

Scenario: add user to the website (sad path)
  When I go to the add user page
  And I fill in "user_email" with "user_fail@foo.com"
  And I press "Sign up"
  Then I should be on the add user page
  And I should see "Error in creating user. Please try again."

Scenario: add non-admin user to the website
  When I go to the add user page
  And I fill in "user_email" with "user2@foo.com"
  And I fill in "user_password" with "password2"
  And I fill in "user_password_confirmation" with "password2"
  And I fill in "user_first_name" with "tristan"
  And I fill in "user_last_name" with "tao"
  And I select "No" from "user_admin"
  And I press "Sign up"
  Then user should be in the database with these fields:
  | email         | password  | admin |
  | user2@foo.com | password2 |    0  |
