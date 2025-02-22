import 'dart:convert';
import 'package:exam_app/app/modules/home/views/exam_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ListTile(
              title: Text("Flutter Developer Test"),
              titleTextStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
              subtitle: Text(
                "Master your flutter development skill with out comprehensive asssement",
              ),
            ),
            Row(
              children: [
                Expanded(
                  flex: 8,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      onChanged: (value) {
                        controller.searchText.value = value;
                        controller.filterExams();
                      },
                      decoration: InputDecoration(
                        hintText: "Search exams...",
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
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
                ),
              ],
            ),
            Expanded(
              child: Obx(
                () => ListView.builder(
                  itemCount: controller.filteredExams.length,
                  itemBuilder: (context, index) {
                    final examModel = controller.filteredExams[index];
                    return ExamCard(exam: examModel, onStartTest: () {});
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
