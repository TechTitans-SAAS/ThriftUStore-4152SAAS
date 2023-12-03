Feature: Item Management

  Background:
    Given I am a logged-in user
    And I am on the My Items page
    And I click the "New Item" button
    And I am on the New Item page
    And I fill in "Title" with "New Item Title"
    And I fill in "Detail" with "This is a new item detail."
    And I fill in "Price" with "19"
    And I upload an image
    And I press "Create Item"
    And I am on the My Items page
    And I click the "Show" button
    Then I am on the item details page

  Scenario: Create a Comment
    When I fill in the comment form with "This is a test comment."
    And I press "Submit Comment"

  #Scenario: Fail to create a Comment
    #When I fill in the comment form with "This is a test comment."
    #And I press "Submit Comment"
    #Then I should see an alert message with the text "Comment has not been created."

  Scenario: Edit a Comment
    When I fill in the comment form with "This is a test comment."
    And I press "Submit Comment"
    Then I am on the item details page
    Given there is a comment by the user
    And I edit the comment form with "This is a new comment."
    And I press "Edit"
    Then I am on the item details page


  #Scenario: User updates a comment that doesn't belong to them
    #Given there is a comment by another user
    #And I fill in the comment form with "This is a new comment."
    #And I press "Edit"
    #Then they should see "Unable to update comment."

  Scenario: Delete a Comment
    When I fill in the comment form with "This is a test comment."
    And I press "Submit Comment"
    Then I am on the item details page
    And I press "Delete"




