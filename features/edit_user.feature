Feature: Edit user

  As an administrator
  I want to be able to modify user info
  So that I can better figure out who's who

  Background:
  	Given the blog is set up with an admin user
  	And the blog is also set up with a non-admin user
  	And I am logged in as the administrator
    And I am on the edit user page for "bbunny@gmail.com"

Scenario: edit name/email
  When I fill in "user_first_name" with "Tazmanian"
  When I fill in "user_last_name" with "Devil"
  When I fill in "user_email" with "tdevil@gmail.com"
  When I select "No" from "user_admin"
  And I press "Update User"
  Then I should be on the edit user page for "tdevil@gmail.com"
  And I should not see "Bugs Bunny"
  And I should see "Successfully updated user!"
  And user should be in the database with these fields:
  | email            | admin | first_name | last_name |
  | tdevil@gmail.com |  0    | Tazmanan   | Devil     |
  
Scenario: edit admin
  When I select "Yes" from "user_admin"
  And I press "Update User"
  Then I should be on the edit user page for "bbunny@gmail.com"
  And I should see "Successfully updated user!"
  And user should be in the database with these fields:
  | email            | admin | first_name | last_name |
  | bbunny@gmail.com |  1    | Bugs       | Bunny     |
  
Scenario: add user to the website (sad path, empty field)
  When I fill in "user_first_name" with ""
  When I fill in "user_last_name" with "Devil"
  When I fill in "user_email" with "tdevil@gmail.com"
  When I select "No" from "user_admin"
  And I press "Update User"
  Then I should be on the edit user page for "bbunny@gmail.com"
  And I should see "Bugs Bunny"
  And I should see "First name can't be blank."
  And user should be in the database with these fields:
  | email            | admin | first_name | last_name |
  | bbunny@gmail.com |  0    | Bugs       | Bunny     |

