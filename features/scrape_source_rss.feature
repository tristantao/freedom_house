Feature: Scrape website via RSS Feed

  As the website admin
  I want to be able to click on a button to initiate a scrape method
  So that I can manually keep all sources up to date
 
  Background:
    Given the blog is set up with an admin user
    And I am logged in as the administrator
    And the site contains a source named "Daily Trust" and with url "http://www.dailytrust.com.ng/index.php/rss/xml/RSS2.0/full"
    

Scenario: Scraper adds at least one new article from source
  When I go to the scraper page
  And I follow "scrape_source_1"
  Then there should be at least "1" articles in the database

