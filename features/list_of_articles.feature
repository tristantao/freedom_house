Feature: display a list of the articles in the database
 
  As a user
  I want to see a list of articles from the news sources
  So that I can inspect a summary of the title and location and date and opening words.

Background: articles have been put in the database
  
  Given the following articles exist:
  | title                                              | date        | author     | location   | link               | source_id |
  | Officials: Deadly attack hits north Nigeria mosque | 14-Oct-2012 | John Smith | Lagos, NG  | http://www.foo.com |     1     |
  | Gunmen kill 20 at mosque in Zaria                  | 15-Oct-2012 | Jim Smith  | Kaduna, NG | http://www.foo.com |     2     |

  And the blog is set up with an admin user
  And I am logged in as the administrator
  And I am on the admin dashboard

Scenario: display list of articles with title
  When I follow "All Articles"
  Then I should see "Officials: Deadly attack hits north Nigeria mosque"
  And I should see "Gunmen kill 20 at mosque in Zaria"

Scenario: display list of articles with date
  When I follow "All Articles"
  And I should see "10/15/12"
  And I should see "10/14/12"

Scenario: display list of articles with location
  When I follow "All Articles"
  And I should see "Lagos"
  And I should see "Kaduna"
