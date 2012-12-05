Feature: Edit Sources

  As an administrator
  I want to be able to edit sources
  So that I can control the sources of text scraped


  Background:
  	Given the blog is set up with an admin user
  	And I am logged in as the administrator
    And the blog contains a source named "tristan's page"

Scenario: edit sources
  When I am on the edit source page for "tristan's page"
  And I fill in "source_name" with "Chris' website"
  And I fill in "source_home_page" with "http://www.chris.com"
  And I select "1" from "source_quality_rating"
  And I fill in "source_url" with "http://rss.cnn.com/rss/cnn_us.rss"
  And I press "Update Source"
  Then I should see "Successfully updated source!"
  Then I should be on the edit source page for "Chris' website"
  And I should not see "tristan's page"

Scenario: edit sources (sad path, blank home page)
  When I am on the edit source page for "tristan's page"
  And I fill in "source_name" with "Chris' website"
  And I fill in "source_home_page" with ""
  And I select "1" from "source_quality_rating"
  And I press "Update Source"
  Then I should see "Home page can't be blank."
  And I should be on the edit source page for "tristan's page"

  



