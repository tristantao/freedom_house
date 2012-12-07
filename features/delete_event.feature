Feature: Delete events from the website

  As a website user
  I want to be able to delete Event
  So that I can remove unwanted events
 
  Background:
    Given the blog is set up with an admin user
    And I am logged in as the administrator
    And the blog is set up with an event named "Genocide in Africa"

Scenario: delete event on the website (happy path)
  When I go to the all events page
  And I follow "delete_event_1"
  Then I should be on the all events page
  And I should see "Event Genocide in Africa has been deleted."

