package com.odde.doughnut.entities;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.odde.doughnut.controllers.json.TrainingData;
import com.odde.doughnut.services.ai.OpenAIChatAboutNoteRequestBuilder;
import java.sql.Timestamp;
import javax.persistence.*;
import lombok.Getter;
import lombok.NonNull;
import lombok.Setter;
import org.springframework.lang.Nullable;

@Entity
@Table(name = "marked_questions")
public class SuggestedQuestionForFineTuning {

  @Id
  @Getter
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private Integer id;

  @ManyToOne
  @JoinColumn(name = "user_id")
  @Getter
  @Setter
  @NonNull
  @JsonIgnore
  private User user;

  @ManyToOne
  @JoinColumn(name = "note_id")
  @Getter
  @Setter
  @NonNull
  @JsonIgnore
  private Note note;

  @ManyToOne
  @JoinColumn(name = "quiz_question_id")
  @Getter
  @Setter
  @JsonIgnore
  @NonNull
  private QuizQuestionEntity quizQuestion;

  @Column(name = "comment")
  @Getter
  @Setter
  private String comment;

  @Column(name = "is_good")
  @Getter
  @Setter
  @NonNull
  private Boolean isGood = true;

  @Column(name = "created_at")
  @Getter
  @Setter
  @Nullable
  private Timestamp createdAt = new Timestamp(System.currentTimeMillis());

  @JsonIgnore
  public TrainingData getTrainingData() {
    var chatRequest =
        new OpenAIChatAboutNoteRequestBuilder()
            .contentOfNoteOfCurrentFocus(getNote())
            .userInstructionToGenerateQuestionWithGPT35FineTunedModel()
            .build();
    var questionEntity = getQuizQuestion();
    return TrainingData.generateTrainingData(
        chatRequest.getMessages(), questionEntity.getRawJsonQuestion());
  }
}