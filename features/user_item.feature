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
    #And I press the button "Back"
    #Then I am on the item list page


  Scenario: Edit an Item
    When I click the "New Item" button
    Then I am on the New Item page
    When I fill in "Title" with "New Item Title"
    And I fill in "Detail" with "This is a new item detail."
    And I fill in "Price" with "19.99"
    And I upload an image
    And I press "Create Item"
    When I am on the My Items page
    Then show me the page
    #And I press "Edit"
    #Then I am on the Editing Item page
    #And I press "Update Item"
    #Then I should be on the item details page
    #And I press "Back"
    #Then I am on the item list page

  Scenario: Destroy an Item
    When I click the "New Item" button
    Then I am on the New Item page
    When I fill in "Title" with "New Item Title"
    And I fill in "Detail" with "This is a new item detail."
    And I fill in "Price" with "19.99"
    And I upload an image
    And I press "Create Item"
    When I am on the My Items page
    Then show me the page
    #When I press "Destroy"
    #Then I should see a confirmation message 'Are you sure?'
    #And I confirm the deletion
    #Then I am on the My Items page



