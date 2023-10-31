Feature: User Login

  Background:
    Given I am on the Log in page

  Scenario: I fill in valid email and password
    When I fill in "Email" with "user@example.com"
    And I fill in "Password" with "password123"
    And press "Log in"
    Then I am on the home page

  Scenario: I click on "Sign up" and is redirected to the registration page
    When I follow "Sign up"
    Then I am on the sign up page

  Scenario: I click on "Forgot your password?" and is directed to the password reset page
    When I follow "Forgot your password?"
    Then I am on the password reset page

  #Scenario: I click on "Sign in with Google OAuth2" and authenticates with Google
    #When I follow "Sign in with Google OAuth2"
    #Then I should be directed to Google's authentication page

  Scenario: I fill in invalid login password
    When I fill in "Email" with "user@example.com"
    And I fill in "Password" with "password12"
    And press "Log in"
    Then I am on the Log in page

  Scenario: I fill in invalid login username
    When I fill in "Email" with "use@example.com"
    And I fill in "Password" with "password123"
    And press "Log in"
    Then I am on the Log in page


  Scenario: Successful Google OAuth2 Authentication
    When I click the "Sign in with GoogleOauth2" button
    When I successfully authenticate with Google
    And I am on the home page

  #Scenario: Failed Google OAuth2 Authentication
    #When I click the "Sign in with GoogleOauth2" button
    #When I fail to authenticate with Google
    #And I am on the home page



