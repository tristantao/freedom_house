Feature: follow the source link of an article to see full text
 
  As an administrator
  I want to be able to click on an article and go to source URI
  So that I can read the entire article

Background: articles have been put in the database
  
  Given the following articles exist:
  | title                                              | date        | location   | source           | link                     |
  | Officials: Deadly attack hits north Nigeria mosque | 14-Oct-2012 | Lagos, NG  | Associated Press | www.boston.com           |
  | Gunmen kill 20 at mosque in Zaria                  | 15-Oct-2012 | Kaduna, NG | Nigerian Tribune | www.nigeriantribune.com  |

  And I am on the admin dashboard page

Scenario: follow a link to go and see an article's full text
  When I follow "All Articles"
  And I follow "Officials: Deadly attack hits north Nigeria mosque"
  Then I should be on the source page for "Officials: Deadly attack hits north Nigeria mosque"
  


