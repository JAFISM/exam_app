import 'package:exam_app/app/data/exam_question_data.dart';
import 'package:flutter/material.dart';

class ExamCard extends StatelessWidget {
  final ExamModel exam;
  final VoidCallback onStartTest;

  const ExamCard({super.key, required this.exam, required this.onStartTest});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  exam.title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color:
                        exam.difficulty == "Beginner"
                            ? Colors.green.shade100
                            : exam.difficulty == "Intermediate"
                            ? Colors.orange.shade100
                            : Colors.red.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    exam.difficulty,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            SizedBox(height: 4),
            Text(exam.description, style: TextStyle(color: Colors.grey[700])),
            SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.timer, size: 18, color: Colors.grey),
                SizedBox(width: 4),
                Text("${exam.duration} minutes"),
                SizedBox(width: 16),
                Icon(Icons.people, size: 18, color: Colors.grey),
                SizedBox(width: 4),
                Text("${exam.attempts} attempts"),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.list, size: 18, color: Colors.grey),
                SizedBox(width: 4),
                Text("${exam.totalQuestions} questions"),
                SizedBox(width: 16),
                Icon(Icons.check_circle, size: 18, color: Colors.grey),
                SizedBox(width: 4),
                Text("${exam.passRate}% pass rate"),
              ],
            ),
            SizedBox(height: 12),
            Wrap(
              spacing: 8,
              children:
                  exam.tags
                      .map(
                        (tag) => Chip(
                          label: Text(tag),
                          backgroundColor: Colors.grey.shade200,
                        ),
                      )
                      .toList(),
            ),
            SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: onStartTest,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                ),
                child: Text("Start Test →"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
