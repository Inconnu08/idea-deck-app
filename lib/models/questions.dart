import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class Question {
  final int id;
  final String question;
  final String option_1;
  final String option_2;
  final String option_3;
  final String option_4;

  Question({
    @required this.id,
    @required this.question,
    @required this.option_1,
    @required this.option_2,
    @required this.option_3,
    @required this.option_4,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'question': question,
      'option_1': option_1,
      'option_2': option_2,
      'option_3': option_3,
      'option_4': option_4,
    };
  }

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      id: map['id'],
      question: map['question'],
      option_1: map['option_1'],
      option_2: map['option_2'],
      option_3: map['option_3'],
      option_4: map['option_4'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Question.fromJson(String source) =>
      Question.fromMap(json.decode(source));
}

class Survey_questions {
  final int id;
  final String question;

  Survey_questions({
    @required this.id,
    @required this.question,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'question': question,
    };
  }

  factory Survey_questions.fromMap(Map<String, dynamic> map) {
    return Survey_questions(
      id: map['id'],
      question: map['question'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Survey_questions.fromJson(String source) =>
      Survey_questions.fromMap(json.decode(source));
}

class Questionnaire {
  final List<Question> questions;
  final List<Survey_questions> survey_questions;

  Questionnaire({
    @required this.questions,
    @required this.survey_questions,
  });

  Map<String, dynamic> toMap() {
    return {
      'questions': questions?.map((x) => x.toMap())?.toList(),
      'survey_questions': survey_questions?.map((x) => x.toMap())?.toList(),
    };
  }

  factory Questionnaire.fromMap(Map<String, dynamic> map) {
    return Questionnaire(
      questions: List<Question>.from(
          map['questions']?.map((x) => Question.fromMap(x))),
      survey_questions: List<Survey_questions>.from(
          map['survey_questions']?.map((x) => Survey_questions.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Questionnaire.fromJson(String source) =>
      Questionnaire.fromMap(json.decode(source));
}

class QuestionnaireState with ChangeNotifier {
  Questionnaire state;
  int currentQuestionNo = 0;
  int totalQuestions = 1;
  List<Map> questions = [];
  List<Map> survey = [];

  initState() {
    currentQuestionNo = 0;
    totalQuestions = 1;
    questions = [];
    survey = [];
  }

  setTotalQuestions(int total) {
    totalQuestions = total;
  }

  nextQuestion() {
    currentQuestionNo++;
    notifyListeners();
  }

  addQuestionAnswer(int id, String answer) {
    questions.add({'id': id, 'answer': answer});
    print(questions);
  }

  addSurveyAnswer(int id, String answer) {
    survey.add({'id': id, 'answer': answer});
  }

  isEnd() {
    return currentQuestionNo < totalQuestions - 1;
  }

  String jsonify() {
    return jsonEncode({'questions': questions, 'survey': survey});
  }
}
