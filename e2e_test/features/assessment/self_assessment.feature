Feature: New questions assessment
  As a trainer, I want to create a notebook with knowledge and questions
  and share it in the Bazaar, so that people can use it to assess their own skill level and knowledge on the topic

  Background:
    Given I am logged in as an existing user
    And there are some notes for the current user:
      | topicConstructor | parentTopic |
      | Countries        |             |
      | Singapore        | Countries   |
      | Vietnam          | Countries   |
      | Japan            | Countries   |
      | Korea            | Countries   |
      | China            | Countries   |
    And notebook "Countries" is shared to the Bazaar
    And there are questions for the note:
      | noteTopic | question                                       | answer   | oneWrongChoice | approved |
      | Singapore | Where in the world is Singapore?               | Asia     | euro           | true     |
      | Vietnam   | Most famous food of Vietnam?                   | Pho      | bread          | true     |
      | Japan     | What is the capital city of Japan?             | Tokyo    | Kyoto          | true     |
      | Japan     | What is the largest city in the Kyushu island? | Fukuoka  | Nagasaki       | true     |
      | Korea     | What is the capital city of Korea?             | Seoul    | Busan          | true     |
      | China     | What is the capital city of China?             | Beijing  | Shanghai       | true     |
      | China     | What is the largest city of China?             | Shanghai | Beijing        | true     |

  Scenario: Complete an assessment with 5 approved questions
    Given I set the number of questions per assessment of the notebook "Countries" to 5
    When I start the assessment on the "Countries" notebook in the bazaar
    And I answer with the following answers:
      | question                                       | answer   |
      | Where in the world is Singapore?               | Asia     |
      | Most famous food of Vietnam?                   | Pho      |
      | What is the capital city of Korea?             | Busan    |
      | What is the capital city of Japan?             | Kyoto    |
      | What is the capital city of China?             | Shanghai |
      | What is the largest city in the Kyushu island? | Nagasaki |
      | What is the largest city of China?             | Beijing  |
    Then I should see the score "Your score: 2 / 5" at the end of assessment

  Scenario: Perform an assessment with all correct answers
    Given I set the number of questions per assessment of the notebook "Countries" to 5
    When I start the assessment on the "Countries" notebook in the bazaar
    And I answer with the following answers:
      | question                                       | answer   |
      | Where in the world is Singapore?               | Asia     |
      | Most famous food of Vietnam?                   | Pho      |
      | What is the capital city of Japan?             | Tokyo    |
      | What is the capital city of China?             | Beijing  |
      | What is the capital city of Korea?             | Seoul    |
      | What is the largest city in the Kyushu island? | Fukuoka  |
      | What is the largest city of China?             | Shanghai |
    Then I should see the score "Your score: 5 / 5" at the end of assessment

  Scenario: Perform an assessment with all wrong answers
    Given I set the number of questions per assessment of the notebook "Countries" to 2
    When I start the assessment on the "Countries" notebook in the bazaar
    And I answer with the following answers:
      | question                                       | answer   |
      | Where in the world is Singapore?               | euro     |
      | What is the capital city of Japan?             | Kyoto    |
      | Most famous food of Vietnam?                   | bread    |
      | What is the capital city of Korea?             | Busan    |
      | What is the capital city of China?             | Shanghai |
      | What is the largest city in the Kyushu island? | Nagasaki |
      | What is the largest city of China?             | Beijing  |
    Then I should see the score "Your score: 0 / 2" at the end of assessment
    And I should see a link to the "Singapore" notebook

  Scenario: Notes order vary from attempt to attempt
    Given I set the number of questions per assessment of the notebook "Countries" to 1
    Then 10 subsequent attempts of assessment on the "Countries" notebook should be random meaning it should not have the same questions each time

  Scenario: Fail to start assessment not enough approve questions
    Given I toggle the approval of the question "What is the capital city of China?" of the topic "China"
    And I toggle the approval of the question "Most famous food of Vietnam?" of the topic "Vietnam"
    And I set the number of questions per assessment of the notebook "Countries" to 8
    When I start the assessment on the "Countries" notebook in the bazaar
    Then I should see error message Not enough questions

  Scenario: Cannot start assessment with 0 questions
    Given I set the number of questions per assessment of the notebook "Countries" to 0
    When I start the assessment on the "Countries" notebook in the bazaar
    Then I should see error message The assessment is not available

  Scenario: Must login to generate assessment
    Given I haven't login
    When I start the assessment on the "Countries" notebook in the bazaar
    Then I should see message that says "Please login first"
