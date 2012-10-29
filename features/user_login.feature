Feature: User Log-in

  As a User
  So that I can securely access the freedom tracker
  I want to be able to login with authentication

  Background:
  	Given the blog is set up without an admin user
    And I am on the home page
  
Scenario: add user to the website
  When I fill in "Email" with "hellojustinchan@gmail.com"
  And I fill in "Password" with "derp1234"
  And I press "Sign in"
  Then I should not see "Dashboard"
