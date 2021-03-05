import 'dart:convert';

class Answers {
  final List<Answer> answers;
  Answers({
    this.answers,
  });

  Map<String, dynamic> toMap() {
    return {
      'questions': answers?.map((x) => x?.toMap())?.toList(),
    };
  }

  factory Answers.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Answers(
      answers:
          List<Answer>.from(map['questions']?.map((x) => Answer.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Answers.fromJson(String source) =>
      Answers.fromMap(json.decode(source));
}

class Answer {
  final int id;
  final String answer;
  Answer({
    this.id,
    this.answer,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'answer': answer,
    };
  }

  factory Answer.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Answer(
      id: map['id'],
      answer: map['answer'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Answer.fromJson(String source) => Answer.fromMap(json.decode(source));
}
