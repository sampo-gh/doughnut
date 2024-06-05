import { Then, When } from "@badeball/cypress-cucumber-preprocessor"
import "../support/string_util"
import start from "../start"
import NotePath from "../support/NotePath"
import SvgCog from "../../src/components/svgs/SvgCog.vue";

When("I start the assessment on {notepath} notebook", (notePath: NotePath) => {
  start.routerToNotebooksPage().navigateToPath(notePath)

  cy.get('#dropdownMenuButton').click()

  cy.contains('Start Assessment').click()
})
