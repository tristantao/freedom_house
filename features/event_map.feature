Feature: Delete events from the website

  As a website user
  I want to be able to see a map
  So that I can visualize events
 
  Background:
    Given the blog is set up with an admin user
    And I am logged in as the administrator
    And the blog is set up with an event named "Genocide in Africa"

Scenario: delete event on the website (happy path)
  When I go to the events map page
  Then I should see events map
