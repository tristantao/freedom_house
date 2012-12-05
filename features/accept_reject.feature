Feature: Be able to accept and reject 

  As an administrator
  So that I may accept only the valid results of the classifier
  I want to see a list of articles sorted by probability of hatefulness
 
Background:
  Given the following articles exist:
    | title                                              | date        | author     | location   | link                  | source_id |
    | Officials: Deadly attack hits north Nigeria mosque | 14-Oct-2012 | John Smith | Lagos, NG  | http://www.google.com |     1     |
  And I am logged in as the administrator

Scenario: Accept an article (happy path)
  When I go to the accept_reject page
  And I follow "accept_article_1"
  Then I should see "Article 1 has been accepted."
  And I should be on the accept_reject page

Scenario: Reject an article (happy path)
  When I go to the accept_reject page
  And I follow "reject_article_2"
  Then I should see "Article 2 has been rejected."
  And I should be on the accept_reject page