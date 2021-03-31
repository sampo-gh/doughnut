package com.odde.doughnut.models.quizFacotries;

import com.odde.doughnut.entities.NoteEntity;
import com.odde.doughnut.entities.ReviewPointEntity;
import com.odde.doughnut.models.QuizQuestion;

import java.util.List;

public class PictureSelectionQuizFactory implements QuizQuestionFactory {
    private final NoteEntity answerNote;
    private final QuizQuestionServant servant;

    public PictureSelectionQuizFactory(QuizQuestionServant servant, ReviewPointEntity reviewPointEntity) {
        this.servant = servant;
        this.answerNote = reviewPointEntity.getNoteEntity();
    }

    @Override
    public List<NoteEntity> generateFillingOptions() {
        return servant.choose5FromSiblings(answerNote, n -> n.getNoteContent().hasPicture() && !n.equals(answerNote));
    }

    @Override
    public String generateInstruction() {
        return "";
    }

    @Override
    public String generateMainTopic() {
        return answerNote.getTitle();
    }

    @Override
    public NoteEntity generateAnswerNote() {
        return answerNote;
    }

    @Override
    public List<QuizQuestion.Option> toQuestionOptions(List<NoteEntity> noteEntities) {
        return servant.toPictureOptions(noteEntities);
    }

}