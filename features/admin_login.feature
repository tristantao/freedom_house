Feature: Admin Log-in

  As an administrator
  So that I can securely access a confidential workbench
  I want to be able to login with authentication

  Background:
    Given I am on the home page
  
Scenario: add user to the website
  When I follow "Login"
  And I fill in user with "hellojustinchan@gmail.com"
  And I fill in password with "derp123"
  And I press submit
  Then I should see "Admin Logged in Successfully!"
