Feature: Admin Log-in

  As an administrator
  So that I can update existing users info
  I want to be able to modify their emails

  Background:
  	Given the blog is set up with an admin user
    And I am on the home page

Scenario: add user to the website
  When I fill in "Email" with "hellojustinchan@gmail.com"
  And I fill in "Password" with "justin"
  And I press "Sign in"
  And I follow "edit_user_1"
  Then I should see "Dashboard"

