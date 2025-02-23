import 'dart:developer';

import 'package:exam_app/app/modules/home/controllers/exam_controller.dart';
import 'package:exam_app/app/modules/home/views/exam_screen_view.dart';
import 'package:exam_app/app/utils/app_text_style.dart';
import 'package:exam_app/app/widget/exam_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            spacing: 8,
            children: [
              titleSubtitleText(
                title: "Flutter Developer Test",
                subtitle:
                    "Master your flutter development skill with out comprehensive asssement",
              ),
              Row(
                children: [
                  Expanded(
                    flex: 8,
                    child: TextField(
                      onChanged: (value) {
                        controller.searchText.value = value;
                        controller.filterExams();
                      },
                      decoration: InputDecoration(
                        hintText: "Search exams...",
                        prefixIcon: Icon(Icons.search),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: BorderSide(
                            color: Colors.grey.shade400,
                            width: 1,
                          ), // Grey border
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: BorderSide(
                            color: Colors.grey.shade600,
                            width: 1.5,
                          ),
                        ),

                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    flex: 4,
                    child: Obx(
                      () => DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.black.withValues(alpha: 0.035),
                        ),
                        child: DropdownButton<String>(
                          padding: EdgeInsets.all(4),
                          underline: SizedBox(),
                          borderRadius: BorderRadius.circular(8),
                          isExpanded: true,
                          value: controller.selectedDifficulty.value,
                          items:
                              ["All", "Beginner", "Intermediate", "Advanced"]
                                  .map(
                                    (level) => DropdownMenuItem(
                                      value: level,
                                      child: Text(level),
                                    ),
                                  )
                                  .toList(),
                          onChanged: (value) {
                            controller.selectedDifficulty.value = value!;
                            controller.filterExams();
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              titleSubtitleText(
                title: "Flutter core",
                subtitle: "Essential Flutter developer concepts",
              ),
              Expanded(
                child: Obx(
                  () => ListView.builder(
                    itemCount: controller.filteredExams.length,
                    itemBuilder: (context, index) {
                      final examModel = controller.filteredExams[index];
                      return ExamCard(
                        exam: examModel,
                        onStartTest: () {
                          if (Get.isRegistered<ExamscreenController>()) {
                            Get.delete<
                              ExamscreenController
                            >(); // Delete previous instance
                          }
                          Get.put(ExamscreenController(examModel));
                          log("exam model ::: ${examModel.title}");
                          Get.to(() => ExamscreenView());
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  titleSubtitleText({String? title, String? subtitle}) {
    return Align(
      alignment: Alignment.topLeft,
      child: Column(
        spacing: 10,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title ?? "", style: boldStyle.copyWith(fontSize: 20)),
          Text(subtitle ?? "", style: subtitleStyle),
        ],
      ),
    );
  }
}
