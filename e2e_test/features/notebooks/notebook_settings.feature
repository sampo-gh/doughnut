Feature: Update Notebook Settings

  Background:
    Given I am logged in as an existing user
    And I have a notebook with head note "LeSS in Action" and settings:
      |Topic          | Number of Questions | Validity Period |
      |LeSS in Action | 10                  | 0               |

  Scenario: Update validity period in notebook settings
    When I update validity period in notebook: "LeSS in Action" with number of questions: 5 and until cert expire: 2 year
    Then I should be able to view the Validity Period of notebook with "LeSS in Action": 2 year in notebook settings
