Feature: Item Management

  Background:
    Given I am a logged-in user
    And I am on the My Items page


  Scenario: Create an Item
    When I click the "New Item" button
    And I am on the New Item page
    When I fill in "Title" with "New Item Title"
    And I fill in "Detail" with "This is a new item detail."
    And I fill in "Price" with "19.99"
    And I upload an image
    And I press "Create Item"


  Scenario: Create an Item with Missing Price
    When I click the "New Item" button
    And  I am on the New Item page
    When I fill in "Title" with "Incomplete Item"
    And I fill in "Detail" with "This is a new item detail."
    And I upload an image
    And I press "Create Item"
    Then I should see an error message "Price can't be blank"
    And I am on the New Item page

  Scenario: Create an Item with Invalid Price
    When I click the "New Item" button
    And  I am on the New Item page
    When I fill in "Title" with "Incomplete Item"
    And I fill in "Detail" with "This is a new item detail."
    And I fill in "Price" with "abc"
    And I upload an image
    And I press "Create Item"
    Then I should see an error message "Price is not a number"
    And I am on the New Item page

  Scenario: Create an Item with Short Title
    When I click the "New Item" button
    And  I fill in "Title" with "Shor"
    And I fill in "Detail" with "This is a new item detail."
    And I fill in "Price" with "1.99"
    And I upload an image
    And I press "Create Item"
    Then I should see an error message "Title is too short (minimum is 5 characters)"
    And I am on the New Item page

  Scenario: Create an Item with Short Detail
    When I click the "New Item" button
    And  I am on the New Item page
    When I fill in "Title" with "Short Detail"
    And I fill in "Detail" with "This"
    And I fill in "Price" with "1.99"
    And I upload an image
    And I press "Create Item"
    Then I should see an error message "Detail is too short (minimum is 10 characters)"
    And I am on the New Item page

  Scenario: Create an Item with Short Detail
    When I click the "New Item" button
    And  I am on the New Item page
    When I fill in "Title" with "New Item Title"
    And I fill in "Detail" with "Short"
    And I fill in "Price" with "1.99"
    And I upload an image
    And I press "Create Item"
    Then I should see an error message "Detail is too short (minimum is 10 characters)"
    And I am on the New Item page


  Scenario: Create an Item with Missing Image
    When I click the "New Item" button
    And  I am on the New Item page
    When I fill in "Title" with "No Image Item"
    And I fill in "Detail" with "This is a new item detail."
    And I fill in "Price" with "19.99"
    And I press "Create Item"
    Then I should see an error message "Image can't be blank"
    And I am on the New Item page



  Scenario: Fail to edit an Item
    When I click the "New Item" button
    And I am on the New Item page
    When I fill in "Title" with "New Item Title"
    And I fill in "Detail" with "This is a new item detail."
    And I fill in "Price" with "19.99"
    And I upload an image
    And I press "Create Item"
    And I am on the My Items page
    When I edit the item "New Item Title" on the my items page
    And I fill in "Title" with "U"
    And I press "Update Item"
    And I should see an error message "Title is too short (minimum is 5 characters)"
