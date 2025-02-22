import 'dart:convert';
import 'package:exam_app/app/data/exam_question_data.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var examList = ExamList(exams: []).obs; // Holds the full exam list
  var filteredExams = <ExamModel>[].obs; // Holds the filtered exam list
  var searchText = "".obs; // Search query
  var selectedDifficulty = "All".obs; // Difficulty filter

  @override
  void onInit() {
    super.onInit();
    loadExams();
  }

  void loadExams() {
    // Parse JSON data
    ExamList data = ExamList.fromJson(jsonDecode(jsonData));
    examList.value = data;
    filteredExams.assignAll(data.exams); // Initialize filtered list
  }

  void filterExams() {
    List<ExamModel> filtered =
        examList.value.exams.where((exam) {
          final matchesSearch = exam.title.toLowerCase().contains(
            searchText.value.toLowerCase(),
          );
          final matchesDifficulty =
              selectedDifficulty.value == "All" ||
              exam.difficulty == selectedDifficulty.value;
          return matchesSearch && matchesDifficulty;
        }).toList();

    filteredExams.assignAll(filtered);
  }

  String jsonData = ''' {
  "exams": [
    {
      "title": "Flutter Fundamentals",
      "description": "Basic widgets, layouts, and core concepts",
      "duration": 45,
      "attempts": 245,
      "totalQuestions": 2,
      "passRate": 78,
      "tags": ["widgets", "layouts", "basics"],
      "difficulty": "Beginner",
      "questions": [
        {
          "questionText": "What is Flutter?",
          "options": ["A web framework", "A mobile development framework", "A database system", "A programming language"],
          "correctAnswerIndex": 1
        },
        {
          "questionText": "Which language is used in Flutter?",
          "options": ["Java", "Kotlin", "Dart", "Swift"],
          "correctAnswerIndex": 2
        }
      ]
    },
    {
      "title": "Dart Programming",
      "description": "Core concepts of the Dart language",
      "duration": 30,
      "attempts": 180,
      "totalQuestions": 2,
      "passRate": 85,
      "tags": ["syntax", "functions", "classes"],
      "difficulty": "Intermediate",
      "questions": [
        {
          "questionText": "What is the default return type of a Dart function?",
          "options": ["void", "null", "dynamic", "int"],
          "correctAnswerIndex": 2
        },
        {
          "questionText": "How do you declare a constant in Dart?",
          "options": ["const variableName", "final variableName", "static variableName", "var variableName"],
          "correctAnswerIndex": 0
        }
      ]
    },
    {
      "title": "State Management in Flutter",
      "description": "Understanding different state management approaches",
      "duration": 60,
      "attempts": 100,
      "totalQuestions": 2,
      "passRate": 70,
      "tags": ["provider", "bloc", "riverpod"],
      "difficulty": "Advanced",
      "questions": [
        {
          "questionText": "Which state management approach is built into Flutter?",
          "options": ["Provider", "Bloc", "SetState", "Riverpod"],
          "correctAnswerIndex": 2
        },
        {
          "questionText": "Which package is recommended for large-scale state management?",
          "options": ["Provider", "Redux", "Bloc", "InheritedWidget"],
          "correctAnswerIndex": 2
        }
      ]
    }
  ]
}
 '''; // sample json data
}
