Feature: Admin Log-in

  As an administrator
  I want to be able to login with authentication
  So that I can securely access a confidential workbench


  Background:
    Given the blog is set up with an admin user
    And I am on the home page
  
Scenario: log in as the admin
  When I fill in "Email" with "hellojustinchan@gmail.com"
  And I fill in "Password" with "derp1234"
  And I press "Sign in"
  Then I should see "Signed in successfully."
  And I should be on the admin dashboard
  
Scenario: log in as the admin (sad path, as in the password is wrong)
  When I fill in "Email" with "hellojustinchan@gmail.com"
  And I fill in "Password" with "derp123"
  And I press "Sign in"
  Then I should see "Invalid email or password."
  And I should be on the login page
