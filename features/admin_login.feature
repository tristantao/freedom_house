Feature: Admin Log-in

  As an administrator
  So that I can securely access a confidential workbench
  I want to be able to login with authentication

  Background:
    Given I am on the home page
  
Scenario: add user to the website
  When I press login
  And I fill in user with "admin_user_name"
  And I fill in password with "admin_password1"
  And I press submit
  Then I should see "Admin Logged in Successfully!"
