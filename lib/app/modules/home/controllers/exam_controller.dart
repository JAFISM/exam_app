import 'dart:async';

import 'package:exam_app/app/data/exam_question_data.dart';
import 'package:exam_app/app/utils/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExamscreenController extends GetxController {
  //TODO: Implement ExamscreenController

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  ExamModel? exam;
  var currentQuestionIndex = 0.obs;
  var selectedAnswers = <int?>[].obs;
  var remainingTime = 45.obs; // Example: 45 minutes

  ExamscreenController(this.exam);

  @override
  void onInit() {
    selectedAnswers.assignAll(List<int?>.filled(exam!.questions.length, null));
    startTimer();
    super.onInit();
  }

  void startTimer() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingTime.value > 0) {
        remainingTime.value--;
      } else {
        timer.cancel();
        calculateScore();
      }
    });
  }

  void selectAnswer(int questionIndex, int selectedOption) {
    selectedAnswers[questionIndex] = selectedOption;
  }

  void nextQuestion() {
    if (currentQuestionIndex.value < exam!.questions.length - 1) {
      currentQuestionIndex.value++;
    }
  }

  void previousQuestion() {
    if (currentQuestionIndex.value > 0) {
      currentQuestionIndex.value--;
    }
  }

  void calculateScore() {
    int correctCount = 0;

    for (int i = 0; i < exam!.questions.length; i++) {
      if (selectedAnswers[i] == exam!.questions[i].correctAnswerIndex) {
        correctCount++;
      }
    }

    double score = (correctCount / exam!.questions.length) * 100;
    // Get.dialog(
    //   SizedBox(
    //     width: Get.context!.width / 1.2,
    //     child: AlertDialog(
    //       shape: RoundedRectangleBorder(
    //         borderRadius: BorderRadius.circular(12),
    //       ),
    //       contentPadding: const EdgeInsets.all(16),
    //       content: Column(
    //         mainAxisSize: MainAxisSize.min,
    //         children: [
    //           Align(
    //             alignment: Alignment.topLeft,
    //             child: const Text(
    //               "Test Complete!",
    //               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
    //             ),
    //           ),
    //           const SizedBox(height: 12),
    //           Text(
    //             "Your Score: ${score.toStringAsFixed(0)}%",
    //             style: const TextStyle(
    //               fontWeight: FontWeight.bold,
    //               fontSize: 24,
    //             ),
    //           ),
    //           const SizedBox(height: 8),
    //           Text(
    //             "Correct Answers: $correctCount / ${exam!.questions.length}",
    //             style: const TextStyle(fontSize: 16),
    //           ),
    //           const SizedBox(height: 12),
    //           if (score < 50)
    //             const Row(
    //               mainAxisAlignment: MainAxisAlignment.center,
    //               children: [
    //                 Icon(Icons.error_outline, color: Colors.red),
    //                 SizedBox(width: 4),
    //                 Text(
    //                   "Need improvement. Keep practicing!",
    //                   style: TextStyle(color: Colors.red),
    //                 ),
    //               ],
    //             ),
    //           const SizedBox(height: 16),
    //           SizedBox(
    //             width: double.infinity,
    //             child: ElevatedButton(
    //               style: ElevatedButton.styleFrom(
    //                 backgroundColor: Colors.black,
    //                 foregroundColor: Colors.white,
    //                 padding: const EdgeInsets.symmetric(vertical: 12),
    //                 shape: RoundedRectangleBorder(
    //                   borderRadius: BorderRadius.circular(8),
    //                 ),
    //               ),
    //               onPressed: () {
    //                 Get.back();
    //                 Get.back(); // Go back to exam list
    //               },
    //               child: const Text(
    //                 "Back to Exam List",
    //                 style: TextStyle(fontSize: 16),
    //               ),
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );

    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: SizedBox(
          width: Get.context!.width / 1.2,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: const Text("Test Complete!", style: boldStyle),
                ),
                const SizedBox(height: 12),
                Text(
                  "Your Score: ${score.toStringAsFixed(0)}%",
                  style: dialogStyle,
                ),
                const SizedBox(height: 8),
                Text(
                  "Correct Answers: $correctCount / ${exam!.questions.length}",
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 12),
                if (score < 50)
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.cancel_outlined, color: Colors.red),
                      SizedBox(width: 4),
                      Text(
                        "Need improvement. Keep practicing!",
                        style: errorStyle,
                      ),
                    ],
                  ),
                const SizedBox(height: 16),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    Get.back();
                    Get.back(); // Go back to exam list
                  },
                  child: const Text("Back to Exam List", style: buttonStyle),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
