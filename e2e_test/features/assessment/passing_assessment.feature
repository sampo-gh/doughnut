@ignore
Feature: Get certificate by an assessment
  As a trainer, I want to provide certificate to the learner when they pass the assessment,
  so that they can use it to show their skill level on the topic.

  As a learner, I want to obtain a certificate when I pass the assessment.

  Background:
    Given I am logged in as an existing user
    And there is an assessment on notebook "Just say 'Yes'" with 2 questions

  Scenario: I should receive a certificate when pass the assessment
    When I get score <Score> when do the assessment on "Just say 'Yes'"
    Then I should <Pass or not> the assessment of "Just say 'Yes'"
    And I should be able to generate certificate <Certificate Generated?>

    Examples:
      | Score | Pass or not | Certificate Generated?
      | 2/2   | pass        | Yes
      | 1/2   | not pass    | No
