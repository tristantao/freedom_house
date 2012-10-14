Feature: Add users to the website

  As the website admin
  So that I can increase the worker count on the project
  I want to be able to add users

  Background:
    Given I am logged in as the administrator
  
Scenario: add user to the website
  When I go to the add user page
  And I fill in user with "user"
  And I fill in password with "password1"
  And I press submi
  Then I should see "User Added Successfully "
