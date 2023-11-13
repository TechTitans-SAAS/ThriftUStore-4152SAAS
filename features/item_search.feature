Feature: Search items

  Background:
    Given I am a logged-in user
    And I am on the My Items page
    When I click the "New Item" button
    And I am on the New Item page
    When I fill in "Title" with "New Item Title"
    And I fill in "Detail" with "This is a new item detail."
    And I fill in "Price" with "19.99"
    And I upload an image
    And I press "Create Item"
    And I am on the item list page

  Scenario: User searches for items
    When I fill in "Search" with "New Item Title"
    And I press "Search"
    Then I should see "New Item Title"

