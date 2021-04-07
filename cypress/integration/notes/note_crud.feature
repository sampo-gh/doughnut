Feature: Note CRUD
  As a learner, I want to maintain my newly acquired knowledge in
  notes, so that I can review them in the future.

  Background:
    Given I've logged in as an existing user

  Scenario: Create a new note
    When I create top level note with:
      | Title    | Description  | UploadPicture      | PictureMask |
      | Sedation | Put to sleep | example-large.png  | 20 40 70 30 |
    And I create top level note with:
      | Title    | Description     | PictureUrl  |
      | Sedition | Incite violence | a_slide.jpg |
    Then I should see these notes belonging to the user at the top level of all my notes
      | title    |
      | Sedation |
      | Sedition |
    And I open "Sedation" note from top level
    And I should see the screenshot matches
