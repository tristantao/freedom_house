Feature: follow the source link of an article to see full text
 
  As an administrator
  I want to be able to click on an article and go to source URI
  So that I can read the entire article

Background: articles have been put in the database
  Given the blog is set up with an admin user
  And I am logged in as the administrator
  And the following articles exist:
  | title                                              | date        | location   | source           | link                            |
  | Officials: Deadly attack hits north Nigeria mosque | 14-Oct-2012 | Lagos, NG  | Associated Press | http://www.boston.com           |
  | Gunmen kill 20 at mosque in Zaria                  | 15-Oct-2012 | Kaduna, NG | Nigerian Tribune | http://www.nigeriantribune.com  |
  And I am on the admin dashboard


Scenario: follow a link to go and see an article's full text
  When I follow "Accept/Reject"
  And I follow "Gunmen kill 20 at mosque in Zaria"
  Then I should honestly be on the source page for "Gunmen kill 20 at mosque in Zaria"
  


