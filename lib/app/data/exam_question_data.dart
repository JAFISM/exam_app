import 'dart:convert';

class ExamList {
  List<ExamModel> exams;

  ExamList({required this.exams});

  factory ExamList.fromJson(Map<String, dynamic> json) {
    return ExamList(
      exams: (json['exams'] as List).map((e) => ExamModel.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'exams': exams.map((e) => e.toJson()).toList()};
  }
}

class ExamModel {
  String title;
  String description;
  int duration;
  int attempts;
  int totalQuestions;
  int passRate;
  List<String> tags;
  String difficulty;
  List<QuestionModel> questions;

  ExamModel({
    required this.title,
    required this.description,
    required this.duration,
    required this.attempts,
    required this.totalQuestions,
    required this.passRate,
    required this.tags,
    required this.difficulty,
    required this.questions,
  });

  factory ExamModel.fromJson(Map<String, dynamic> json) {
    return ExamModel(
      title: json['title'],
      description: json['description'],
      duration: json['duration'],
      attempts: json['attempts'],
      totalQuestions: json['totalQuestions'],
      passRate: json['passRate'],
      tags: List<String>.from(json['tags']),
      difficulty: json['difficulty'],
      questions:
          (json['questions'] as List)
              .map((q) => QuestionModel.fromJson(q))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'duration': duration,
      'attempts': attempts,
      'totalQuestions': totalQuestions,
      'passRate': passRate,
      'tags': tags,
      'difficulty': difficulty,
      'questions': questions.map((q) => q.toJson()).toList(),
    };
  }
}

class QuestionModel {
  String questionText;
  List<String> options;
  int correctAnswerIndex;

  QuestionModel({
    required this.questionText,
    required this.options,
    required this.correctAnswerIndex,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      questionText: json['questionText'],
      options: List<String>.from(json['options']),
      correctAnswerIndex: json['correctAnswerIndex'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'questionText': questionText,
      'options': options,
      'correctAnswerIndex': correctAnswerIndex,
    };
  }
}
