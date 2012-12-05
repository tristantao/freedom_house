Feature: follow the source link of an article to see full text
 
  As an administrator
  I want to be able to click on an article and go to source URI
  So that I can read the entire article

Background: articles have been put in the database
  Given the blog is set up with an admin user
  And I am logged in as the administrator
  
  And I am on the admin dashboard
  And the following articles exist:
    | title                                              | date        | author     | location   | link                   | source_id |
    | Officials: Deadly attack hits north Nigeria mosque | 14-Oct-2012 | John Smith | Lagos, NG  | http://www.foo.com     |     1     |
    | Gunmen kill 20 at mosque in Zaria                  | 15-Oct-2012 | Jim Smith  | Kaduna, NG | http://www.google.com |     2     |

Scenario: follow a link to go and see an article's full text
  When I follow "Accept/Reject"
  And I follow "Gunmen kill 20 at mosque in Zaria"
  Then I should honestly be on the source page for "Gunmen kill 20 at mosque in Zaria"
  
