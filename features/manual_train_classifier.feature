Feature: Train Classifier Manually

  As an administrator
  So that I can retrain the classifier with new article data
  I want to click a button that will retrain the classifier
 
Background:
    Given the blog is set up with an admin user
    And I am logged in as the administrator

Scenario: Retrain the classifier (happy path)
  When I go to the classifier page
  And I press "retrain"
  Then I should see "Classifier has been retrained."
  And I should be on the classifier page
