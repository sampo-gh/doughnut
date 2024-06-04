package com.odde.doughnut.entities.converters;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.odde.doughnut.services.ai.MultipleChoicesQuestion;
import jakarta.persistence.AttributeConverter;
import jakarta.persistence.Converter;
import java.io.IOException;

@Converter
public class MCQToJsonConverter implements AttributeConverter<MultipleChoicesQuestion, String> {

  private final ObjectMapper objectMapper = new ObjectMapper();

  @Override
  public String convertToDatabaseColumn(MultipleChoicesQuestion attribute) {
    try {
      return objectMapper.writeValueAsString(attribute.cloneQuestion());
    } catch (JsonProcessingException e) {
      throw new IllegalArgumentException("Error converting list to JSON", e);
    }
  }

  @Override
  public MultipleChoicesQuestion convertToEntityAttribute(String dbData) {
    try {
      return objectMapper.readValue(dbData, MultipleChoicesQuestion.class);
    } catch (IOException e) {
      throw new IllegalArgumentException("Error converting JSON to list", e);
    }
  }
}