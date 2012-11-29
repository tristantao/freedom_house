Feature: Be able to accept and reject 

  As an administrator
  So that I may accept only the valid results of the classifier
  I want to see a list of articles sorted by probability of hatefulness
 
Background:
    Given the blog is set up with an admin user
    And I am logged in as the administrator

Scenario: Accept an article (happy path)
  When I go to the accept_reject page
  And I press "accept_article_1"
  Then I should see "Article 1 has been accepted."
  And I should be on the accept_reject page

