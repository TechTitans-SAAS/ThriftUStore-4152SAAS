Feature: Navigation from Home Page

  Background:
    Given I am on the home page

  Scenario: Clicking "Shop Now" button
    When I click the "Shop Now" button
    Then I am on the Log in page

  Scenario: Clicking "Login" button
    When I click the "Login" button
    Then I am on the Log in page

  Scenario: Clicking "Register" button
    When I click the "Register" button
    Then I am on the sign up page
