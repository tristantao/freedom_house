Feature: determine the location of from the article
 
  As a user
  I want to see a list of locations that the article talks about
  So that I can easily detect the relationship between articles and events

Background: display article with locations
  Given the following articles exist:
  | title                                              | date        | author     | location   | link    | source_id |
  | Officials: Deadly attack hits north Nigeria mosque | 14-Oct-2012 | John Smith | Lagos, NG  | foo.com |     1     |
  | Gunmen kill 20 at mosque in Zaria                  | 15-Oct-2012 | Jim Smith  | Kaduna, NG | foo.com |     2     |

  And the blog is set up with an admin user
  And I am logged in as the administrator
  And I am on the admin dashboard

Scenario: mine location out of articles
  When I go to the articles page
  Then I should see "Jaji"
  And I should see all the locations determined
