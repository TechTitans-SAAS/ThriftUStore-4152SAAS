Feature: Item Management

  Background:
    Given I am a logged-in user
    And I am on the My Items page

  Scenario: View a List of Created Items (Empty List)
    Given I have not created any items
    Then I should see the message "You have no items listed"


  Scenario: Create a New Item and View a List of Created Items
    When I click the "New Item" button
    Then I am on the New Item page
    When I fill in "Title" with "New Item Title"
    And I fill in "Detail" with "This is a new item detail."
    And I fill in "Price" with "19.99"
    And I upload an image
    And I press "Create Item"
    When I am on the My Items page
    Then I should see the following items in the table:
      | Title          | Detail                    | Price | Image | Actions                  |
      | New Item Title | This is a new item detail. | $19.99 |  | Show Edit Destroy |


  Scenario: Sort Items by Price in Ascending Order
    When I click the "New Item" button
    Then I am on the New Item page
    When I fill in "Title" with "New Item Title"
    And I fill in "Detail" with "This is a new item detail."
    And I fill in "Price" with "19.99"
    And I upload an image
    And I press "Create Item"
    Then I am on the My Items page
    When I click the "New Item" button
    Then I am on the New Item page
    When I fill in "Title" with "Old Item Title"
    And I fill in "Detail" with "This is an old item detail."
    And I fill in "Price" with "9.99"
    And I upload an image
    And I press "Create Item"
    Then I am on the item list page
    When I click the "Sort by Price" button
    Then I should see items sorted by price in ascending order

  Scenario: Sort Items by Title in Ascending Order
    When I click the "New Item" button
    Then I am on the New Item page
    When I fill in "Title" with "New Item Title"
    And I fill in "Detail" with "This is a new item detail."
    And I fill in "Price" with "19.99"
    And I upload an image
    And I press "Create Item"
    Then I am on the My Items page
    When I click the "New Item" button
    Then I am on the New Item page
    When I fill in "Title" with "Old Item Title"
    And I fill in "Detail" with "This is an old item detail."
    And I fill in "Price" with "9.99"
    And I upload an image
    And I press "Create Item"
    Then I am on the item list page
    When I click the "Sort by Title" button
    Then I should see items sorted by title in ascending order


  Scenario: Navigate Back to Profile
    When I click the "Back to Profile" button
    Then I am on the Profile page


  Scenario: Show an Item
    When I click the "New Item" button
    Then I am on the New Item page
    When I fill in "Title" with "New Item Title"
    And I fill in "Detail" with "This is a new item detail."
    And I fill in "Price" with "19.99"
    And I upload an image
    And I press "Create Item"
    When I am on the My Items page
    And I click the "Show" button
    Then I am on the item details page
    Then show me the page


  Scenario: Edit an Item
    When I click the "New Item" button
    And I am on the New Item page
    When I fill in "Title" with "New Item Title"
    And I fill in "Detail" with "This is a new item detail."
    And I fill in "Price" with "19.99"
    And I upload an image
    And I press "Create Item"
    And I am on the My Items page
    When I edit the item "New Item Title" on the my items page
    And I fill in "Title" with "Updated Item Title"
    And I press "Update Item"

  Scenario: Destroy an Item
    When I click the "New Item" button
    And I am on the New Item page
    When I fill in "Title" with "New Item Title"
    And I fill in "Detail" with "This is a new item detail."
    And I fill in "Price" with "19.99"
    And I upload an image
    And I press "Create Item"
    And I am on the My Items page
    When I click the "Destroy" button

