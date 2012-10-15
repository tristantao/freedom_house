Feature: display a list of the articles in the database
 
  As an administrator
  I want to see a list of articles from the news sources
  So that I can inspect a summary of the title and location and date and opening words.

Background: articles have been put in the database
  
  Given the following articles exist:
  | title                                              | date        | location   | source           |
  | Officials: Deadly attack hits north Nigeria mosque | 14-Oct-2012 | Lagos, NG  | Associated Press |
  | Gunmen kill 20 at mosque in Zaria                  | 15-Oct-2012 | Kaduna, NG | Nigerian Tribune |

  And I am on the admin page

Scenario: display list of movies
  When I press "List All Articles"
  Then I should see "Officials: Deadly attack hits north Nigeria mosque"
  And I should see "14-Oct-2012"
  And I should see "Lagos"
  And I should see "Gunmen kill 20 at mosque in Zaria"
  And I should see "15-Oct-2012"
  And I should see "Kaduna"


