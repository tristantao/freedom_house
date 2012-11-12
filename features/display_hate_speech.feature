Feature: display the hate speech in an article

  As an admin or user
  I want to be able to see the text that the machine learner classified as hate speech
  So that I can approve or disapprove the machine's work
 
  Background:
    Given the blog is set up with an admin user
    And I am logged in as the administrator
    And the webscraper extracted an article from a source
    And the machine learner processed that article

Scenario:  hate speech of an article should be displayed
  When I go to the home page
  Then I should see "violence between Muslims and Christians"
  
  
