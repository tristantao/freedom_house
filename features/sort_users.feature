Feature: Sort Users

 As an admin
 I want to be able to sort the user list by id, name, privileges, email
 so that I can view users more efficiently

 Background:
    Given the blog is set up with an admin user
    And I am logged in as the administrator
    And the following users exist:
  | users                  | email                |
  | Felix Li               |felix.li@berkeley.edu | 
  | Chris Balcells         |balcells@berkeley.edu |
  | Tristan Tao            |tristan@berkeley.edu  |
  | Jose Carrillo          |jose@berkeley.edu     |

Scenario: user clicks sort by name  (happy path)
  When I go to the users page
  And I press "sort_user_name"
  Then I should see "Chris Balcells" before "Felix Li"

