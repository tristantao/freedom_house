Feature: Add users to the website

  As the website admin
  So that I can increase the worker count on the project
  I want to be able to add users

  Background:
    Given I am logged in as the administrator
  
Scenario: add admin user to the website (happy path)
  When I go to the add user page
  And I fill in "user_email" with "user1@foo.com"
  And I fill in "user_password" with "password1"
  And I check "user_admin"
  And I press "Create"
  Then user should be in the database with these fields:
  | email         | password  | admin |
  | user1@foo.com | password1 |    1  |

Scenario: add user to the website (sad path)
  When I go to the add user page
  And I fill in "user_email" with "user_fail@foo.com"
  And I press "Create"
  Then I should be on the 

Scenario: add non-admin user to the website
  When I go to the add user page
  And I fill in "user_email" with "user2@foo.com"
  And I fill in "user_password" with "password2"
  And I uncheck "user_admin"
  And I press "Create"
  Then user should be in the database with these fields:
  | name          | password  | admin |
  | user2@foo.com | password2 |    0  |
