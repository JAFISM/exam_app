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
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ListTile(
              isThreeLine: true,
              title: Text("Flutter Developer Test"),
              titleTextStyle: boldStyle.copyWith(fontSize: 20),
              subtitle: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  "Master your flutter development skill with out comprehensive asssement",
                  style: subtitleStyle,
                ),
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
                ),
                SizedBox(height: 10),
                Expanded(
                  flex: 4,
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
            ListTile(
              isThreeLine: true,
              title: Text("Flutter core"),
              titleTextStyle: boldStyle.copyWith(fontSize: 20),
              subtitle: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  "Essential Flutter developer concepts",
                  style: subtitleStyle,
                ),
              ),
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
                        Get.put(ExamscreenController(examModel));
                        Get.to(ExamscreenView());
                      },
                    );
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
