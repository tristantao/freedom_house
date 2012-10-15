Feature: User Log-in

  As a User
  So that I can securely access the freedom tracker
  I want to be able to login with authentication

  Background:
    Given I am on the home page
  
Scenario: add user to the website
  When I press login
  And I fill in user with "user_name"
  And I fill in password with "password1"
  And I press submit
  Then I should see "User Logged in Successfully!"
