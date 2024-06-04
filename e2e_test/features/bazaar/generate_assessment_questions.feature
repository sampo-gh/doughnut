
Feature: Bazaar generate
  As a trainer, I want to generate to assessment questions in the Bazaar so that I can
  print the questions for notebook.
Background:
  Given I am logged in as an existing user

  Scenario: display button to generate questions from notebook
    Given there are some notes for the current user:
    | topicConstructor | testingParent  | details             |
    | LeSS in Action   |                | An awesome training |
    | team             | LeSS in Action |                     |
    | tech             | LeSS in Action |                     |
    | airgile          | LeSS in Action |                     |
    | scrum            | LeSS in Action |                     |
    | PO               | LeSS in Action |                     |
    And notebook "LeSS in Action" is shared to the Bazaar
    When I go to the bazaar
    Then I should see the "Generate assessment questions" button on notebook "LeSS in Action"

  @ignore
  Scenario: generate questions from notebook
    Given I am logged in as an existing user
    When I click on generate assessment questions button
    Then generate "5" questions
  @ignore
  Scenario: show error message if there are less than 5 notes in a notebook when generating questions
    Given I am logged in as an existing user
    And there are some notes for the current user:
      | topicConstructor | testingParent  | details             |
      | LeSS in Action   |                | An awesome training |
      | team             | LeSS in Action |                     |
      | tech             | LeSS in Action |                     |
    When I click on generate assessment questions button
    Then display error message that says ""
  @ignore
  Scenario: show error message if user is not logged in when generating questions
    Given I haven't login
    When I click on generate assessment questions button
    Then display error message that says ""