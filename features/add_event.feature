Feature: Add events to the website

  As a website user
  I want to be able to add Event
  So that I can compare between Events and Hate speech
 
  Background:
    Given the blog is set up with an admin user
    And I am logged in as the administrator

Scenario: add new event to the website (happy path)
  When I go to the add event page
  And I fill in "event_name" with "Genocide in Africa"
  And I fill in "event_description" with "A few people were killed today"
  And I fill in "event_date" with "Jan 12, 2012"
  And I select "Nigeria" from "event_country"

  And I press "Create"
  Then I should see "Event Genocide in Africa has been created"

Scenario: add new source to the website (sad path)
  When I go to the add event page
  And I fill in "event_name" with "invalid_name"
  And I press "Create"
  Then I should not see "invalid_name"
  Then I should be on the add event page
  And I should see "Error in creating event. Please try again."
