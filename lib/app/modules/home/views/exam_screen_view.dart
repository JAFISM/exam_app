import 'package:exam_app/app/data/exam_question_data.dart';
import 'package:exam_app/app/modules/home/controllers/exam_controller.dart';
import 'package:exam_app/app/utils/app_text_style.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class ExamscreenView extends GetView<ExamscreenController> {
  const ExamscreenView({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Obx(() {
          final currentQuestionIndex = controller.currentQuestionIndex.value;
          final question = controller.exam!.questions[currentQuestionIndex];

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                const SizedBox(height: 16),
                Text(
                  "Question ${currentQuestionIndex + 1} of ${controller.exam!.questions.length}",
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  question.questionText,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                _buildOptionsList(question),
                const Spacer(),
                _buildNavigationButtons(),
              ],
            ),
          );
        }),
      ),
    );
  }

  ///  **Builds the top header with exam name & timer**
  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          controller.exam!.title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Row(
          children: [
            const Icon(Icons.timer_outlined, size: 20, color: Colors.black),
            const SizedBox(width: 5),
            Obx(
              () => Text(
                "${controller.remainingTime ~/ 60}:${(controller.remainingTime % 60).toString().padLeft(2, '0')}",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  ///  **Builds the list of answer options**
  Widget _buildOptionsList(QuestionModel question) {
    return Column(
      children: List.generate(
        question.options.length,
        (index) => Obx(
          () => GestureDetector(
            onTap:
                () => controller.selectAnswer(
                  controller.currentQuestionIndex.value,
                  index,
                ),
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(vertical: 6),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(
                  color:
                      controller.selectedAnswers[controller
                                  .currentQuestionIndex
                                  .value] ==
                              index
                          ? Colors.black
                          : Colors.grey.shade300,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  question.options[index],
                  style: boldStyle.copyWith(fontSize: 16),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  ///  **Builds the navigation buttons (Next & Submit)**
  Widget _buildNavigationButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          onPressed: controller.previousQuestion,
          child: const Text("Previous"),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          onPressed: () {
            if (controller.currentQuestionIndex.value ==
                controller.exam!.questions.length - 1) {
              controller.calculateScore();
            } else {
              controller.nextQuestion();
            }
          },
          child: Obx(
            () => Text(
              controller.currentQuestionIndex.value ==
                      controller.exam!.questions.length - 1
                  ? "Submit"
                  : "Next",
            ),
          ),
        ),
      ],
    );
  }
}
