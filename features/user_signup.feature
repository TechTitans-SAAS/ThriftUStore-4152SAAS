Feature: User Sign Up/ Register

  Background:
    Given I am on the sign up page

  Scenario: Valid user registration
    When I fill in "Email" with "newuser@example.com"
    And I fill in "Password" with "password123"
    And I fill in "Password confirmation" with "password123"
    And I press "Sign up"
    Then I am on the home page

  Scenario: Email already taken
    Given I am on the sign up page
    When I fill in "Email" with "existinguser@example.com"
    And I fill in "Password" with "password123"
    And I fill in "Password confirmation" with "password123"
    And I press "Sign up"
    And I sign out
    When I am on the sign up page
    And I fill in "Email" with "existinguser@example.com"
    And I fill in "Password" with "password123"
    And I fill in "Password confirmation" with "password123"
    And I press "Sign up"
    Then I should see an error message "Email has already been taken"


  Scenario: Password mismatch
    When I fill in "Email" with "newuser@example.com"
    And I fill in "Password" with "password123"
    And I fill in "Password confirmation" with "mismatchedpassword"
    And I press "Sign up"
    Then I should see an error message "Password confirmation doesn't match Password"

  Scenario: Password length too short
    When I fill in "Email" with "newuser@example.com"
    And I fill in "Password" with "short"
    And I fill in "Password confirmation" with "short"
    And I press "Sign up"
    Then I should see an error message "Password is too short (minimum is 6 characters)"
