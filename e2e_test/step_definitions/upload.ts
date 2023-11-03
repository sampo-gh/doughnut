/// <reference types="cypress" />
/// <reference types="../support" />
// @ts-check

import { Given } from "@badeball/cypress-cucumber-preprocessor"

Given(
  "I have {int} positive feedbacks and {int} negative feedbacks",
  (positive: number, negative: number) => {
    for (let i = 0; i < positive; i++) {
      cy.get('a[title="send this question for fine tuning the question generation model"]').click()
      cy.findByRole("button", { name: "👍 Good" }).click()
      cy.findByRole("button", { name: "OK" }).click()
    }

    for (let i = 0; i < negative; i++) {
      cy.get('a[title="send this question for fine tuning the question generation model"]').click()
      cy.findByRole("button", { name: "👎 Bad" }).click()
      cy.findByRole("button", { name: "OK" }).click()
    }
  },
)