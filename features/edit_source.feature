Feature: Edit Sources

  As an administrator
  I want to be able to edit sources
  So that I can control the sources of text scraped


  Background:
  	Given the blog is set up with an admin user
    And the blog contains a source named "tristan's page"

Scenario: edit sources
  When I am on the edit source page for "tristan's page"
  And I fill in "source_name" with "Chris' website"
  And I fill in "source_home_page" with "chris.com"
  And I fill in "source_quality_rating" with "1"
  And I press "Update Source"
  Then I should be on the edit source page for "Chris' website"
  And I should not see "tristan's page"

