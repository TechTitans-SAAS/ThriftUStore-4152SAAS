Feature: User Profile Management

  Background:
    Given I am a logged-in user
    And I am on the Profile page

  Scenario: View User Profile
    Then I should see "Full Name"
    And I should see "Email"
    And I should see "Address"
    And I should see "Zip Code"
    And I should see "State"
    And I should see "Country"
    And I should see "Description"

  Scenario: Edit User Profile Successfully
    When I click the "Edit Profile" button
    Then I should be on the Edit User page
    And I fill in "Password" with "newpassword"
    And I fill in "Password confirmation" with "newpassword"
    And I press "Update"
    Then I am on the home page


  Scenario: Cancel Account
    When I click the "Edit Profile" button
    Then I should be on the Edit User page
    When I click the "Cancel my account" button
    #Then I should see a confirmation message "Are you sure?

