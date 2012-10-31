Feature: Add sources to the website

  As the website admin
  I want to be able to add sources
  So that the webscraper can find more articles
 
  Background:
    Given the blog is set up with an admin user
    And I am logged in as the administrator

Scenario: add new source to the website (happy path)
  When I go to the add source page
  And I fill in "source_name" with "tristan's website"
  And I fill in "source_home_page" with "tristan.com"
  And I fill in "source_quality_rating" with "10"
  And I press "Create"
  Then source should be in the database with these fields:
  | name              | home_page   | quality_rating  |
  | tristan's website | tristan.com | 10              |

Scenario: add new source to the website (sad path)
  When I go to the add source page
  And I fill in "source_name" with "invalid_source"
  And I press "Create"
  Then I should not see "invalid_source"
  Then I should be on the add source page
  And I should see "Error in creating source. Please try again."
