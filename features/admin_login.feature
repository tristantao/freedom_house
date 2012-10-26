Feature: Admin Log-in

  As an administrator
  So that I can securely access a confidential workbench
  I want to be able to login with authentication

  Background:
  	Given the blog is set up with an admin user
    And I am on the home page
  
Scenario: add user to the website
  When I fill in "Email" with "hellojustinchan@gmail.com"
  And I fill in "Password" with "justin"
  And I press "Sign in"
  Then I should see "Welcome to the Administrator Dashboard."
