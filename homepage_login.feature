Feature: Navigation from Home Page

  Background:
    #Given I am a logged-in user


  Scenario: Clicking "Shop Now" button when logged in
    Given I am a logged-in user
    When I am on the My Items page
    When I click the "New Item" button
    Then I am on the New Item page
    When I fill in "Title" with "New Item Title"
    And I fill in "Detail" with "This is a new item detail."
    And I fill in "Price" with "19.99"
    And I upload an image
    And I press "Create Item"
    When I am on the home page
    And I click the "Shop Now" button
    Then I am on the item list page


  Scenario: Clicking "My Profile" button when logged in
    When I am on the home page
    And I click the "My Profile" button
    Then I am on the Profile page

  Scenario: Clicking "My Items" button when logged in
    When I am on the home page
    And I click the "My Items" button
    Then I am on the My Items page

  Scenario: Clicking "Log out" button when logged in
    When I am on the home page
    And I click the "Log out" button
    Then I am on the Log in page

