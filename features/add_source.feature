Feature: Add sources to the website

  As the website admin
  I want to be able to add sources
  So that the webscraper can find more articles
 
  Background:
    Given the blog is set up with an admin user
    And I am logged in as the administrator

Scenario: add new source to the website (happy path)
  When I go to the add source page
  And I fill in "source_name" with "New York Times"
  And I fill in "source_home_page" with "www.nytimes.com"
  And I fill in "source_quality_rating" with "10"
  And I fill in "source_url" with "http://www.nytimes.com/services/xml/rss/nyt/HomePage.xml"
  And I press "Create"
  Then source should be in the database with these fields:
  | name           | home_page       |url                                                     | quality_rating  |
  | New York Times | www.nytimes.com |http://www.nytimes.com/services/xml/rss/nyt/HomePage.xml| 10              |

Scenario: add new source to the website (sad path, blank url, homepage, and quality_rating)
  When I go to the add source page
  And I fill in "source_name" with "invalid_source"
  And I press "Create"
  Then I should not see "invalid_source"
  Then I should be on the add source page
  And I should see "Home page can't be blank. Quality rating can't be blank. Quality rating is not a number. Url is incorrectly formatted"

Scenario: add new source to the website (sad path, url has spaces)
  When I go to the add source page
  And I fill in "source_name" with "invalid_RSS"
  And I fill in "source_home_page" with "www.google.com"
  And I fill in "source_quality_rating" with "1"
  And I fill in "source_url" with "http://www.go ogle.com"
  And I press "Create"
  Then I should be on the add source page
  And I should see "Url is not formatted correctly."

Scenario: add new source to the website (sad path, url does not exist)
  When I go to the add source page
  And I fill in "source_name" with "invalid_RSS"
  And I fill in "source_home_page" with "www.google.com"
  And I fill in "source_quality_rating" with "1"
  And I fill in "source_url" with "http://www.fjfjfjfjfjfjfjfjfjfjfjfjfjfjfjfjfjfjfjfjfjfjfj.com/"
  And I press "Create"
  Then I should be on the add source page
  And I should see "Url does not exist."

Scenario: add new source to the website (sad path, url doesn't begin with 'http://')
  When I go to the add source page
  And I fill in "source_name" with "invalid_RSS"
  And I fill in "source_home_page" with "www.google.com"
  And I fill in "source_quality_rating" with "1"
  And I fill in "source_url" with "www.google.com"
  And I press "Create"
  Then I should be on the add source page
  And I should see "Url is incorrectly formatted"

Scenario: add new source to the website (sad path, invalid RSS url, all fields filled)
  When I go to the add source page
  And I fill in "source_name" with "invalid_RSS"
  And I fill in "source_home_page" with "www.google.com"
  And I fill in "source_quality_rating" with "1"
  And I fill in "source_url" with "http://www.google.com"
  And I press "Create"
  Then I should be on the add source page
  And I should see "Url is not a valid RSS feed."
