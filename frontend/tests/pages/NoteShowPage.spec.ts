/**
 * @jest-environment jsdom
 */
import { screen } from "@testing-library/vue";
import NoteShowPage from "@/pages/NoteShowPage.vue";
import helper from "../helpers";
import makeMe from "../fixtures/makeMe";

jest.useFakeTimers();

helper.resetWithApiMock(beforeEach, afterEach);

describe("all in note show page", () => {
  describe("note show", () => {
    const note = makeMe.aNoteRealm.please();
    const stubResponse = {
      notePosition: makeMe.aNotePosition
        .for(note.note)
        .inCircle("a circle")
        .please(),
      notes: [note],
    };

    it(" should fetch API to be called TWICE when viewType is not included ", async () => {
      helper.apiMock
        .expectingGet(`/api/notes/${note.id}`)
        .andReturnOnce(stubResponse);
      helper
        .component(NoteShowPage)
        .withProps({ rawNoteId: `${note.id}` })
        .render();
      helper.apiMock.verifyCall(`/api/notes/${note.id}`);
      await screen.findByText(note.note.title);
    });

    it(" should fetch API to be called when viewType is mindmap ", async () => {
      const viewTypeValue = "mindmap";
      helper.apiMock
        .expectingGet(`/api/notes/${note.id}/overview`)
        .andReturnOnce(stubResponse);
      helper
        .component(NoteShowPage)
        .withProps({ rawNoteId: `${note.id}`, viewType: viewTypeValue })
        .render();
      helper.apiMock.verifyCall(`/api/notes/${note.id}/overview`);
      await screen.findByText(note.note.title);
    });
  });
});
