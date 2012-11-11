Feature: Edit user

  As an administrator
  I want to be able to modify events
  So that I can update events with more details when they become available

  Background:
  	Given the blog is set up with an admin user
  	And the blog is also set up with a non-admin user
  	And I am logged in as the administrator
    And the blog is set up with an event named "Genocide in Africa"
    And I am on the edit event page for "Genocide in Africa"

Scenario: edit event
  When I fill in "event_name" with "Genocide in Nigeria"
  And I fill in "event_description" with "Update2: Multiple people killed"
  And I press "Update Event"
  Then I should be on the edit event page for "Genocide in Nigeria"
  And I should not see "Genocide in Africa"
  And I should see "Successfully updated event!"

Scenario: edit event to an invalid form(sad path, empty field)
  When I fill in "event_name" with ""
  And I press "Update Event"
  Then I should be on the edit event page for "Genocide in Africa"
  And I should see "Error in editing event. Please try again."


