Feature: Password Reset

  Background:
    Given I am on the password reset page

  #Scenario: Password reset request
    #When I press "Send me reset password instructions"

  Scenario: I click on "Log in" and is redirected to the registration page
    When I follow "Log in"
    Then I am on the Log in page

  Scenario: I click on "Sign up" and is redirected to the registration page
    When I follow "Sign up"
    Then I am on the sign up page

  #Scenario: I click on "Sign in with Google OAuth2" and authenticates with Google
    #When I press "Sign in with Google OAuth2"
    #Then I should be directed to Google's authentication page
